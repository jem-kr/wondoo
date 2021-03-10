<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/cbti.css">
</head>
<body class="container">
	<article class="start">
		<h1 class="text-center">나의 취향에 맞는 커피는 무엇일까요?</h1>
		<img src="images/logo2.png" alt="logo2" class="img" width="300px"
			id="cafelogo">
		<button type="button" class="btn btn-primary btn-lg"
			onclick="start();">테스트 시작하기</button>
	</article>

	<article class="question">
		<div class="progress">
			<div class="progress-bar progress-bar-striped active"
				role="progressbar" style="width: calc(100/ 12 * 1%)"></div>
		</div>
		<h2 class="text-center" id="title">문제</h2>
		<input id="type" type="hidden" value="SNS">
			<button id="A" type="button" class="btn btn-info btn-lg">Light</button>
			<button id="B" type="button" class="btn btn-warning btn-lg">Dark</button>
	</article>

	<article class="result">
		<h1 class="text-center" id="commentary">저희가 추천하는 커피는</h1>
		<img id="img" src="images/brazil.jpg" alt="coffeepic"
			class="img-thumbnail">
		<h2 id="coffeebean" class="text-center">원두이름</h2>
		<h4 id="explain" class="text-center">설명....</h4>
	</article>
	<input type="hidden" id="SNS" value="0">
	<input type="hidden" id="BNB" value="0">
	<input type="hidden" id="FANA" value="0">
	<input type="hidden" id="CCCB" value="0">


	<script>
		var num = 1;
		var q = {
			1 : {
				"title" : "커피의 신 맛 좋아하시나요?",
				"type" : "SNS",
				"A" : "네! 저는 커피의 신 맛도 좋아요 :)",
				"B" : "아니요 :( 신 맛이 덜 한 커피가 좋아요"
			},
			2 : {
				"title" : "그렇다면, 쓴 맛은 어떠세요?",
				"type" : "BNB",
				"A" : "좋아요~ 씁쓸한 커피맛",
				"B" : "한약 먹는 것 같아서 별로에요...."
			},
			3 : {
				"title" : "어떤 종류의 커피 향이 좋으세요?",
				"type" : "FANA",
				"A" : "고소한 커피향이 좋아요!",
				"B" : "산뜻한 커피향이 좋아요!"
			},
			4 : {
				"title" : "찾으시는 커피의 종류가 무엇인가요?",
				"type" : "CCCB",
				"A" : "저는 간편한 캡슐커피를 찾아요",
				"B" : "커피의 특징이 잘 살아있는 원두커피요"
			}
		/* 5:{"title":"문제5", "type":"BNB", "A":"B", "B":"NB"},
		6:{"title":"문제6", "type":"BNB", "A":"B", "B":"NB"},
		7:{"title":"문제7", "type":"FANA", "A":"FA", "B":"NA"},
		8:{"title":"문제8", "type":"FANA", "A":"FA", "B":"NA"},
		9:{"title":"문제9", "type":"FANA", "A":"FA", "B":"NA"},
		10:{"title":"문제10", "type":"WCCO", "A":"WC", "B":"CO"},
		11:{"title":"문제11", "type":"WCCO", "A":"WC", "B":"CO"},
		12:{"title":"문제12", "type":"WCCO", "A":"WC", "B":"CO"} */
		}
		var result = {
			"SBFACC" : {
				"coffeebean" : "네스프레소 마스터오리진 콜롬비아",
				"explain" : "생동감있는 느낌의 산미와 와인향과 붉을 과일향이 은은히 퍼지는 커피입니다.",
				"img" : "images/capsule/colombia.jpg"
			},
			"SBFACB" : {
				"coffeebean" : "에티오피아 예가체프",
				"explain" : "부드러운 바디와 달콤하면서 잘익은 과일향과 꽃향기가 특징이며 신맛과 중후함이 돋보이는 커피입니다.",
				"img" : "images/origin/ethiopia.jpg"
			},
			"SBNACC" : {
				"coffeebean" : "네스프레소 이스피라치오네 이탈리아나 로마",
				"explain" : "짧은 시간 라이트 로스팅하여 진한 우디향, 곡물향과 살짝 감도는 산미와 우아한 아로마가 특징입니다.",
				"img" : "images/capsule/roma.jpg"
			},
			"SBNACB" : {
				"coffeebean" : "과테말라 안티구아",
				"explain" : "화산지역에서 경작되는 고급 스모크커피의 대명사로 풍부한 바디와 향미를 가진 커피입니다. ",
				"img" : "images/origin/guatemala.jpg"
			},
			"SNBFACC" : {
				"coffeebean" : "네스프레소 에스프레소&룽고 코지",
				"explain" : "동아프리카와 중남미산 아라비카를 가볍게 로스팅한 커피로 구수한 곡물향과 섬세하고 균형있는 맛이 특징입니다.",
				"img" : "images/capsule/cosi.jpg"
			},
			"SNBFACB" : {
				"coffeebean" : "도미니카 AA",
				"explain" : "해안지역 재배한 커피로 상큼한 신맛과 흐릿한 바닐라향, 톡 쏘는 스파이시함이 특징인 커피입니다.",
				"img" : "images/origin/dominica.jpg"
			},
			"SNBNACC" : {
				"coffeebean" : "네스프레소 마스터오리진 에티오피아",
				"explain" : "최고 수준의 아로마를 자랑하는 에티오피아는 오렌지 꽃향과 함께 풍부한 향미를 선사합니다.",
				"img" : "images/capsule/ethiopia.jpg"
			},
			"SNBNACB" : {
				"coffeebean" : "콜롬비아 수프리모",
				"explain" : "마일드 커피의 대명사로 적당한 바디감, 과하지 않은 쓴맛, 지속적인 단 맛, 고소함, 산미 등 밸런스가 좋은 커피입니다.",
				"img" : "images/origin/colombia.jpg"
			},
			"NSNBNACC" : {
				"coffeebean" : "네스프레소 에스프레소&룽고 리니지오룽고",
				"explain" : "브라질과 콜롬비아산 커피가 균형있게 블렌딩되어 특유의 곡물향과 함께 순하고 부드러운 느낌을 줍니다.",
				"img" : "images/capsule/linizio.jpg"
			},
			"NSNBNACB" : {
				"coffeebean" : "인도네시아 몬순",
				"explain" : "산도가 가장 낮은 커피 중 하나로, 독특한 향과 단 맛, 구수함이 특징입니다.",
				"img" : "images/origin/indonesia.jpg"
			},
			"NSNBFACC" : {
				"coffeebean" : "네스프레소 에스프레소&룽고 비발토룽고",
				"explain" : "별도의 로스팅을 거친 남미와 동아프리카의 아라비카들의 블렌딩으로 로스팅향과 은은한 꽃향을 느끼게 합니다.",
				"img" : "images/capsule/vivalto.jpg"
			},
			"NSNBFACB" : {
				"coffeebean" : "케냐 피베리",
				"explain" : "전 세계 커피나무의 7% 불과한 변종 커피로 묵직한 바디, 은은한 산미와 부드러운 단맛이 특징입니다. ",
				"img" : "images/origin/kenya.jpg"
			},
			"NSBNACC" : {
				"coffeebean" : "네스프레소 이스피라치오네 이탈리아나 나폴리",
				"explain" : "오랜시간 다크 로스팅한 커피로 입안가득 크리미함과 강렬한 로스팅향을 지닌 커피입니다.",
				"img" : "images/capsule/napoli.jpg"
			},
			"NSBNACB" : {
				"coffeebean" : "인도네시아 만델링",
				"explain" : "커피의 왕이라는 별칭을 가진 커피로, 부드러우면서도 묵직한 농도와 초콜릿같은 풍미를 가진 개성이 진한 커피입니다.",
				"img" : "images/origin/indonesia.jpg"
			},
			"NSBFACC" : {
				"coffeebean" : "네스프레소 에스프레소&룽고 포티시오룽고",
				"explain" : "중남미산 원두와 인도 몬순 말라바를 블렌딩하여 깊은 여운과 진한 강도, 풍부한 맛과 바디, 강렬한 로스팅향이 특징입니다.",
				"img" : "images/capsule/fortissio.jpg"
			},
			"NSBFACB" : {
				"coffeebean" : "코스타리카 따라주",
				"explain" : "브라운 슈가와 같은 깊은 단 맛, 견과의 고소함이 특징으로 부드러운 산미와 밸런스를 가지는 커피입니다.",
				"img" : "images/origin/costarica.jpg"
			}
		}
		function start() {
			$(".start").hide();
			$(".question").show();
			next();
		}
		$('#A').click(function() {
			var type = $('#type').val();
			var preValue = $('#' + type).val();
			$('#' + type).val(parseInt(preValue) + 1);
			next();
		});
		$('#B').click(function() {

			next();
		});

		function next() {
			if (num == 5) {
				$(".question").hide();
				$('.result').show();
				var coffeeti = "";
				($('#SNS').val() == 0) ? coffeeti += "NS" : coffeeti += "S";
				($('#BNB').val() == 0) ? coffeeti += "NB" : coffeeti += "B";
				($('#FANA').val() == 0) ? coffeeti += "FA" : coffeeti += "NA";
				($('#CCCB').val() == 0) ? coffeeti += "CB" : coffeeti += "CC";
				// alert(coffeeti);
				$('#img').attr("src", result[coffeeti]["img"]);
				$('#coffeebean').html(result[coffeeti]["coffeebean"]);
				$('#explain').html(result[coffeeti]["explain"]);
			} else {
				$('.progress-bar').attr('style',
						'width: calc(100/4*' + num + '%)');
				$('#title').html(q[num]["title"]);
				$('#type').val(q[num]["type"]);
				$('#A').html(q[num]["A"]);
				$('#B').html(q[num]["B"]);
				num++;
			}
		}
	</script>


</body>
</body>
</html>