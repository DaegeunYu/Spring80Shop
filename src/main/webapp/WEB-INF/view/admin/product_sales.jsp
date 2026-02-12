<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tr class="bg-white">
    <td colspan="10" class="p-8">
        <div class="flex flex-col items-center justify-center bg-gray-50 rounded-[2rem] p-10 border border-gray-100 shadow-inner">
            <h2 class="text-xl font-black text-gray-800 mb-8">전체 품목별 판매 점유율</h2>
            <div class="flex flex-col md:flex-row items-center gap-12 w-full max-w-4xl">
                <div style="width: 350px; height: 350px; position: relative;">
                    <canvas id="productPieChart"></canvas>
                </div>
                <div id="customLegend" class="flex-1 grid grid-cols-1 gap-3 max-h-[350px] overflow-y-auto px-4"></div>
            </div>
        </div>
    </td>
</tr>

<tr class="bg-white">
    <td colspan="10" class="p-8">
        <div class="flex flex-col items-center justify-center bg-gray-50 rounded-[2rem] p-10 border border-gray-100 shadow-inner">
            <h2 class="text-xl font-black text-gray-800 mb-8">상품 중량별 판매 분포 (누적)</h2>
            <div class="w-full max-w-5xl" style="height: 480px;">
                <canvas id="stackedBarChart"></canvas>
            </div>
        </div>
    </td>
</tr>

<script>
(function() {
    requestAnimationFrame(() => {
        const colors20 = [
            '#E6194B', '#3CB44B', '#FFE119', '#4363D8', '#F58231',
            '#911EB4', '#42D4F4', '#F032E6', '#BFEF45', '#FABEBE',
            '#469990', '#E6BEFF', '#9A6324', '#FFFAC8', '#800000',
            '#AAFFC3', '#808000', '#FFD8B1', '#000075', '#A9A9A9'
        ];

        // 데이터 수집 및 실적 필터링 
        const rawLabels = [];
        const rawPieData = [];
        
        <c:forEach var="s" items="${productStats}">
            rawLabels.push("${s.productName}");
            rawPieData.push(Number("${s.TOTAL_WEIGHT}") || 0); 
        </c:forEach>

        const activeIndices = rawPieData.map((v, i) => v > 0 ? i : -1).filter(i => i !== -1);
        const originalLabels = activeIndices.map(i => rawLabels[i]);
        const pieData = activeIndices.map(i => rawPieData[i]);
        const totalWeight = pieData.reduce((a, b) => a + b, 0);

        // 원형 차트 실행
        const pieCtx = document.getElementById('productPieChart');
        if (pieCtx && originalLabels.length > 0) {
            new Chart(pieCtx, {
                type: 'doughnut',
                plugins: [ChartDataLabels],
                data: {
                    labels: originalLabels,
                    datasets: [{
                        data: pieData,
                        // 20개 색상을 데이터 인덱스에 맞춰 순환 배정
                        backgroundColor: pieData.map((_, i) => colors20[i % colors20.length]),
                        borderWidth: 4, 
                        borderColor: '#ffffff',
                        hoverOffset: 20
                    }]
                },
                options: { 
                    cutout: '70%', 
                    responsive: true, 
                    maintainAspectRatio: false, 
                    plugins: { 
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.label || '';
                                    let value = context.parsed || 0;
                                    return ` \${label}: \${value.toLocaleString()}g`;
                                }
                            }
                        },
                        datalabels: {
                            color: '#fff',
                            font: { weight: 'bold', size: 12 },
                            formatter: (value) => {
                                if (!value || totalWeight === 0) return null;
                                return ((value / totalWeight) * 100).toFixed(1) + '%';
                            }
                        }
                    } 
                }
            });
        }

        // 목록 생성
        const legendContainer = document.getElementById('customLegend');
        if (legendContainer) {
            legendContainer.innerHTML = ''; // 초기화
            originalLabels.forEach((label, i) => {
                const val = pieData[i];
                const percent = totalWeight > 0 ? ((val / totalWeight) * 100).toFixed(1) : 0;
                
                const div = document.createElement('div');
                div.className = "flex items-center justify-between p-4 bg-white rounded-2xl shadow-sm border border-gray-100";
                div.innerHTML = `
                    <div class="flex items-center gap-3">
                        <span class="w-4 h-4 rounded-full" style="background-color: \${colors20[i % colors20.length]}"></span>
                        <span class="text-sm font-bold text-gray-700">\${label}</span>
                    </div>
                    <div class="text-right">
                        <span class="text-base font-black text-blue-600">\${percent}%</span>
                        <span class="text-[10px] text-gray-400 ml-2">\${val.toLocaleString()}g</span>
                    </div>
                `;
                legendContainer.appendChild(div);
            });
        }

        // 누적 막대 차트 실행 
        const barCtx = document.getElementById('stackedBarChart');
        if (barCtx && originalLabels.length > 0) {
            const rawDistData = [
                <c:forEach var="item" items="${weightDist}" varStatus="loop">
                    { 
                        pName: "${item.productName}", 
                        wGroup: parseInt("${item.weightGroup}".replace(/[^0-9]/g, "")) || 0, 
                        count: Number("${item.totalCount}") 
                    }${!loop.last ? ',' : ''}
                </c:forEach>
            ];

            const weightGroups = [200, 350, 500, 1000];
            const barColors = ['#4363D8', '#3CB44B', '#FFE119', '#F58231']; 

            const barDatasets = weightGroups.map((weight, idx) => {
                const weightSums = [];
                const itemCounts = [];

                originalLabels.forEach(name => {
                    const match = rawDistData.find(d => d.pName === name && d.wGroup === weight);
                    if (match) {
                        weightSums.push(match.count * match.wGroup);
                        itemCounts.push(match.count);
                    } else {
                        weightSums.push(0);
                        itemCounts.push(0);
                    }
                });

                return {
                    label: weight + 'g',
                    data: weightSums,
                    counts: itemCounts,
                    backgroundColor: barColors[idx],
                    borderRadius: 4
                };
            });

            new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: originalLabels.map(name => name.split(' ')), 
                    datasets: barDatasets
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        mode: 'index',     
                        intersect: false   
                    },
                    scales: {
                        x: { stacked: true, grid: { display: false }, ticks: { autoSkip: false, font: { size: 10 } } },
                        y: { stacked: true, beginAtZero: true, title: { display: true, text: '판매 중량 (g)' } }
                    },
                    plugins: {
                        legend: { position: 'bottom' },
                        tooltip: {
                        	itemSort: (a, b) => b.datasetIndex - a.datasetIndex,
                            callbacks: {
                                label: function(context) {
                                    const weightValue = context.parsed.y;
                                    const countValue = context.dataset.counts[context.dataIndex];
                                    if (weightValue === 0) return null;
                                    return ` \${context.dataset.label}: \${weightValue.toLocaleString()}g (\${countValue.toLocaleString()}개)`;
                                }
                            }
                        }
                    }
                }
            });
        }
    });
})();
</script>
