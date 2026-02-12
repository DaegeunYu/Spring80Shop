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
        // --- 1. 데이터 수집 및 실적 필터링 ---
        const rawLabels = [];
        const rawPieData = [];
        
        <c:forEach var="s" items="${productStats}">
            rawLabels.push("${s.productName}");
            rawPieData.push(Number("${s.TOTAL_WEIGHT}")); 
        </c:forEach>

        // 실적이 있는 상품만 선별
        const activeIndices = rawPieData.map((v, i) => v > 0 ? i : -1).filter(i => i !== -1);
        const originalLabels = activeIndices.map(i => rawLabels[i]);
        const pieData = activeIndices.map(i => rawPieData[i]);

        // --- 2. 도넛 차트 (기존 동일) ---
        const pieCtx = document.getElementById('productPieChart');
        if (pieCtx && originalLabels.length > 0) {
            new Chart(pieCtx, {
                type: 'doughnut',
                plugins: [ChartDataLabels],
                data: {
                    labels: originalLabels,
                    datasets: [{
                        data: pieData,
                        backgroundColor: [
                            '#E6194B', '#3CB44B', '#FFE119', '#4363D8', '#F58231',
                            '#911EB4', '#42D4F4', '#F032E6', '#BFEF45', '#FABEBE'
                        ],
                        borderWidth: 4, borderColor: '#ffffff'
                    }]
                },
                options: { cutout: '70%', responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
            });
        }

        // --- 3. 누적 막대 차트 (구조 변경: 단순 숫자 배열 사용) ---
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
                // 막대 높이(중량 합계) 데이터 배열
                const weightSums = [];
                // 툴팁용 수량 데이터 배열 (커스텀 프로퍼티)
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
                    data: weightSums, // 단순 숫자 배열로 변경 (출력 보장)
                    counts: itemCounts, // 툴팁 참조용 커스텀 필드
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
                    scales: {
                        x: { stacked: true, grid: { display: false }, ticks: { autoSkip: false, maxRotation: 0, font: { size: 10 } } },
                        y: { stacked: true, beginAtZero: true, title: { display: true, text: '판매 중량 (g)' } }
                    },
                    plugins: {
                        legend: { position: 'bottom' },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    const weightValue = context.parsed.y;
                                    const countValue = context.dataset.counts[context.dataIndex]; // 별도 배열에서 개수 추출
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