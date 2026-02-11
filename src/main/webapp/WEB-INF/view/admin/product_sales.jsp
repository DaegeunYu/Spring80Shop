<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tr class="bg-white">
    <td colspan="10" class="p-8">
        <div class="flex flex-col items-center justify-center bg-gray-50 rounded-[2rem] p-10 border border-gray-100 shadow-inner">
            <h2 class="text-xl font-black text-gray-800 mb-8">전체 품목별 판매 점유율</h2>
            
            <div class="flex flex-col md:flex-row items-center gap-12 w-full max-w-4xl">
                <div style="width: 350px; height: 350px; position: relative;">
                    <canvas id="productPieChart"></canvas>
                </div>
                
                <div id="customLegend" class="flex-1 grid grid-cols-1 gap-3 max-h-[350px] overflow-y-auto px-4">
                    </div>
            </div>
        </div>
    </td>
</tr>

<script>
(function() {
    requestAnimationFrame(() => {
        const labels = [];
        const data = [];
        const colors = [
            '#E6194B', '#3CB44B', '#FFE119', '#4363D8', '#F58231',
            '#911EB4', '#42D4F4', '#F032E6', '#BFEF45', '#FABEBE',
            '#469990', '#E6BEFF', '#9A6324', '#FFFAC8', '#800000',
            '#AAFFC3', '#808000', '#FFD8B1', '#000075', '#A9A9A9'
        ];

        <c:forEach var="s" items="${productStats}">
            labels.push("${s.productName}");
            // TOTAL_COUNT를 TOTAL_WEIGHT로 변경
            data.push(Number("${s.TOTAL_WEIGHT}")); 
        </c:forEach>

        const ctx = document.getElementById('productPieChart');
        if (!ctx) return;

        const total = data.reduce((a, b) => a + b, 0);

        new Chart(ctx, {
            type: 'doughnut',
            plugins: [ChartDataLabels],
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors.slice(0, labels.length),
                    borderWidth: 5,
                    borderColor: '#f9fafb',
                    hoverOffset: 20
                }]
            },
            options: {
                cutout: '65%',
                responsive: true,
                maintainAspectRatio: false,
                plugins: { 
                    legend: { display: false }, 
                    datalabels: {
                        color: '#fff',
                        font: { weight: 'bold', size: 12 },
                        formatter: (value) => {
                            if (value === 0 || total === 0) return null;
                            return ((value / total) * 100).toFixed(1) + '%';
                        }
                    }
                }
            }
        });

        const legendContainer = document.getElementById('customLegend');
        if (legendContainer) {
            labels.forEach((label, i) => {
                const percent = total > 0 ? ((data[i] / total) * 100).toFixed(1) : 0;
                const div = document.createElement('div');
                div.className = "flex items-center justify-between p-4 bg-white rounded-2xl shadow-sm border border-gray-100";
                div.innerHTML = `
                    <div class="flex items-center gap-3">
                        <span class="w-4 h-4 rounded-full" style="background-color: \${colors[i % colors.length]}"></span>
                        <span class="text-sm font-bold text-gray-700">\${label}</span>
                    </div>
                    <div class="text-right">
                        <span class="text-base font-black text-blue-600">\${percent}%</span>
                        <span class="text-[10px] text-gray-400 ml-1">\${data[i].toLocaleString()}g</span>
                    </div>
                `;
                legendContainer.appendChild(div);
            });
        }
    });
})();
</script>