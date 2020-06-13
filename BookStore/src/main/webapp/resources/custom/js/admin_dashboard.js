var chartData;
var chartOptions = {
						//responsive: false,
						maintainAspectRatio : false //부모가 만든 크기 안에 꽉 차게 함(default 값: true)
					};
var chartType = 'line';
var mainColor = "rgba(75,192,192,1)"; // generator 사용전
var subColor = "rgba(75,192,192,0.4)"; // generator 사용전
$(function(){
	makeChartAjax();											//화면을 로딩하자마자 차트를 구성함
	setInterval(makeChartAjax, 10000);							//10초마다 차트를 다시 그림(그 과정에서 데이터도 새로 갱신됨)
	$('#termOption').on('change', makeChartAjax);				//termOption(차트간 데이터 단위(ex)연,월,일,시,분,초단위가 변경될때마다 차트가 다시 그려짐)
	$('#chartDataCntOption').on('change', makeChartAjax);		//chartDataCntOption(차트에 표현되는 데이터의 개수)가 변경될때마다 차트가 다시그려짐
	$('#chartShapeOption').on('change', makeChartAjax);			//chartShapeOption(차트의 모양옵션)이 변경될때마다 차트가 다시그려짐
});
//차트를 그려주는 함수
//차트의 데이터를 받는 과정을 포함함
function makeChartAjax(){
	$('#myChartContainer').empty();
	$('#myChartContainer').append('<canvas id="myChart"></canvas>');
	$.ajax({
	      type:'post',
	      async:true,
	      url:"/BookStore/admin/getSalesDataWithOptions.do",
	      contentType : 'application/x-www-form-urlencoded;charset=UTF-8', //넘어가는 데이터를 인코딩하기 위함
	      data :{
	    	  		"option" : $('#termOption').val(),
	    	  		"chartDataCnt" : $('#chartDataCntOption').val()
	      },
	      dataType : 'json',
	      success : function(resultData){
	    	  chartType = $(chartShapeOption).val();
	    	  chartData= makeAjaxChartData(resultData);
	    	  makeChart(chartData, chartOptions);
	    	  
	      },
	      error:function(request,status,error){
	         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	   });
}
//ajax에서 받아온 json 데이터를 가공하여 차트의 데이터를 만들어주는 과정
function makeAjaxChartData(resultData){
	var dataLabels = new Array();
	var lineChartData = new Array();
	
	if(chartType!=='line'){ // line타입이 아니면 그래프 색깔 생성
		mainColor = mainColorGenerator(resultData.reducedSalesListSize);
	}else if(chartType==='line'){
		mainColor = "rgba(75,192,192,1)";
	}
	
	for(var i=0; i< resultData.reducedSalesListSize; i++){
		dataLabels.push(resultData.reducedSalesList[i].BUYDATE);
		lineChartData.push(resultData.reducedSalesList[i].BUYPRICE);
	}

	var chartData ={
		      labels : dataLabels,
		      datasets : [
		         {
		            label : "매출표",
		            fill : false,
		            lineTension : 0.1,
		            backgroundColor : mainColor, //subColor
		            borderColor : mainColor,
		            borderCapStyle : 'butt',
//		            borderDash : {},
//		            borderDashOffset : 0.0,
		            borderJoinStyle : 'miter',
		            pointBorderColor : mainColor,
		            pointBackgroundColor : '#fff',
		            pointBorderWitdh : 2,
		            pointRadius : 1,
		            pointHitRadius : 10,
		            data : lineChartData,
		            spanGaps : false
		         },
		      ]
		   };
   return chartData;
}
//makeChartAjax에서 내부적으로 불리는 함수 : chart.js에서 제공하는 기본함수
function makeChart(chartData, chartOptions){
	   var ctx = document.getElementById('myChart').getContext('2d');
	   var myChart = new Chart(ctx, {
	      //type : 'bar',
		   type : chartType,
	      data : chartData,
	      options : chartOptions
	   });
}
//차트의 색깔을 구성해주는 함수
//	ㄴ 차트의 데이터 개수만큼 색깔을 만들어서 반환함
//	ㄴ makeAjaxChartData에서 내부적으로 불림
function mainColorGenerator(size){
	var resultColor;
	var rRanNum =  Math.floor(Math.random()*255);
	var gRanNum =  Math.floor(Math.random()*255);
	var bRanNum =  Math.floor(Math.random()*255);
	
	if(size>1){
		resultColor = new Array();
		for(var i=0; i<size; i++){
			rRanNum =  Math.floor(Math.random()*255);
			gRanNum =  Math.floor(Math.random()*255);
			bRanNum =  Math.floor(Math.random()*255);
			temp = 'rgba(' +rRanNum + ', ' + gRanNum + ', ' + bRanNum + ')';
			resultColor.push(temp);
		}
	}else if(size==1){
		resultColor = 'rgba(' +rRanNum + ', ' + gRanNum + ', ' + bRanNum + ')';
	}
	
	return resultColor
}