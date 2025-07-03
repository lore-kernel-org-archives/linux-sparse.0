Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D462D9493
	for <linux-sparse@vger.kernel.org>; Thu,  3 Jul 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541576; cv=fail; b=K6uYdR60cQZ/TWJbfA/WIxx+s8yUXqfjfa8WIQFMq0Xk4fa00/jxrFikRD58H1XHxsfnhpBtSogZYOr30JTZjQcKp7zbekkHN8uTYfdcNMbW3k6pTgpzzpEliLStHmezK1TIW5H4HLNPUoRGBqrQrLRGFzd+GjFxCKTaH6cd9OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541576; c=relaxed/simple;
	bh=eSImTvL4jbYysEbM+/gvjiztSYV/kH+nJEE6prxR86A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JB0qltIthtOB8hD5oXrGbCc6tcy18nutFLLcls0rJEiqyavlaV0UXtEYsvxs2yS0Wj/tP9Ju3PdlXMWOsEZ0RBo1Mleyz51YWk0qRrfHmobm+HJ5qR4BQpY+vsws9VYh9qo3Ro4KHHiNI3xxQfeudNHCBz9ceKCzpFeOmXq8McI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Hq6P8zv2; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=UkJ2ye89; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Hq6P8zv2";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="UkJ2ye89"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5635mTNE1562664
	for <linux-sparse@vger.kernel.org>; Thu, 3 Jul 2025 12:19:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	dk201812; bh=KjIfq7Dq1qtDYXuqJwLlZY15dsg/KyQd5S0ixLBuwZY=; b=Hq6
	P8zv2fdeZM0MKED96y8FN6omuXLL9fdYSD50h18n1twlC8+n8+2aNe40lg0mn45L
	43RWFllaATIlYjF1FBdtCQ80hVq0B648v7TdPq9Ni3804tsuAMqBJc7z/gZpHLWy
	+zlxgen1FBjAnJDSATvYDchZf1QlCdiK6e9XbTAz85RVwTf8gLeJD+kNwfct3kZk
	H3MDr9VS+UaBdtY4gGNuCGmAFnRodjo7XUMUFNe7qTfDp+/Xbbg/GGZZPTq6EYxA
	iHoSsvk3WjgYJcyWh+Vuye+ANzLA1rcpxc9bQ06zc7HXUn0YENkGYmj3FO6dica6
	T4x+aTmY46pcZfsmIfw==
Received: from lo3p265cu004.outbound.protection.outlook.com (mail-uksouthazon11020124.outbound.protection.outlook.com [52.101.196.124])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 47j8ftbr19-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-sparse@vger.kernel.org>; Thu, 03 Jul 2025 12:19:31 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxYbxVCvyLB/xOnDcZ0OGBQ3HHR6n5dm8nwy4AJAAQE3QgpT9c/s//r1OyCaKBZPdcwQAEZkdgbzFRCreffHyR/dciq72bw3AyOKYkPbH/jaBbDxKy0Ruk07eMk7oEBhnWBNgPbWkbiO5BQZzjDGnDLNI7eNtFmQ4gIvuN5IjZphrVUchx3i6DaktzdC0IiHlkm0oPtzYXI8UEveQdGYYWQotub54ExfGp0SljlE+j06D6f1SOVl/W9+uaX0bhdkUSAj6OXK5rSOIvnLbx1JMJTTp/c93lxc2xQPHa4v9q0tft8xmsu8huk/Q6RFFNzevMrmZ/iA3LVlUCHkoBm9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjIfq7Dq1qtDYXuqJwLlZY15dsg/KyQd5S0ixLBuwZY=;
 b=YODP6ZAMhzzxdrF2iyMchXWfD8/3CuhSM/uRopzLl9W9t7jQwlC9dhf4RyzErH5ie4FpTWavkUkVYfuukhSrEZVtX8XyBt1DeEJKhKN4PLm20dOrRqlwA8fhxMNUWSi0wYiPt1Bl/5zTrlk/y95znCygCipVEMvxYoZ6gC1Nbc1t5YDpMdcRrjSUFwKCGSiIavZ6TgAjITeiGeWiqI8xgTtbUW16REW/Hd5Ha9W8YbeZOv2cwgcXQmISIsPVgH/h5EIKyMbBL5W9Ly7QcYwWM9bQeCtj7sExemVFRR95hu9Wv6YAVdzV8/RQtqoc3VifzEyLdew3bY7LI+qs73eNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjIfq7Dq1qtDYXuqJwLlZY15dsg/KyQd5S0ixLBuwZY=;
 b=UkJ2ye89oChfvAOUKwo2Bx9nkXOfwBnmQ60RazmLuD7noH/dkXAwj9qksKQNP4BDZVEm/pNc1R/hHeBYlBy1fgsWcjnSwlnP7BAVF5aTsNd/562hllhIG0aH9WIBubhd5em8mBk4pj8Yw/diQcZ7/0ICozkRKZVk/bjA4dm1i7Q=
Received: from CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e7::8) by
 CWLP265MB5608.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Thu, 3 Jul 2025 11:19:28 +0000
Received: from CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8e9d:6b2f:9881:1e15]) by CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8e9d:6b2f:9881:1e15%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 11:19:28 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: [BUG] Alignment of structure members does not always propagate
Thread-Topic: [BUG] Alignment of structure members does not always propagate
Thread-Index: AQHb7AxWO1V7vHqg0Euz7ZfzQbLJNw==
Date: Thu, 3 Jul 2025 11:19:28 +0000
Message-ID: <ea14a74d-2da3-480e-bb84-33904aaeb10b@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB3397:EE_|CWLP265MB5608:EE_
x-ms-office365-filtering-correlation-id: f7393819-bc1d-40e9-65b5-08ddba237973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFN6a2xnQ2s3TUZBWXA2Y2NNNERVWXFtd3MvZEpuL0Rzd2p6ak9MTUtCWDlw?=
 =?utf-8?B?K0tXMU1iSVRuMFlnZG5PSjREd0tRQnd4TkNiME15K1Nkck1EYm5NTGgxTmdR?=
 =?utf-8?B?a2lzd3p0UDNCTFRMRzdYY25xOEE0b1RaWXU4bGVlOTRnRXV1cHBjemVEbE5a?=
 =?utf-8?B?UmdndkduQmxpZWRjV0wvWG5vZlcrSENiRXF6aVphZkVwSjhsdm1pRzVZQWtG?=
 =?utf-8?B?bmhBaklabU5teHUwRjdPSGhuSm4xTWxTclRUZjNCeXdDWlo1ZHpFUEZRUDJ3?=
 =?utf-8?B?eXFlZlBSMXdhak5ub0xjNmN5T29SZ0pFK1Axck1tMnlXSm03RXZKVkh6OGZS?=
 =?utf-8?B?QWpaUDNTOU5vc0JzTThKQ1BkQk43RWJjQ3l6YjArYXhDRHIxZkdrZ2pnNkFw?=
 =?utf-8?B?NHBGb0MwMmw2bTVmeUtFUjBPcFVJaWNKajJwRHVyYjY1VFNLZHdzUmJWRzZ4?=
 =?utf-8?B?N25CaU9YNzgzVmFaSUorZTdwc1lRcGJEbVM4dE16QzVHcGx5WTFweVYxdkF2?=
 =?utf-8?B?RjJnekJld24xTjBteDNEMzM3OVZHa2pHdkwzRmJwQVplR1ZpSGcvUG8zck0y?=
 =?utf-8?B?eU9vSStJdTVUalk2ZWJ6ZGJMcys1UUFRcmx3aHpsWHE0NkxFWjgyV01RMlFz?=
 =?utf-8?B?Q0xHcEtlbmZ2ZnJEM0VuQUtjTkUySG1YVFVuRnFSbmR6dldFT1RkR3dmWUJ3?=
 =?utf-8?B?UTdXNzl3OWdYb3ZLUXZXekdHUGU4VTFydW5HRjdHOWhDVmhCRnNXMFVHVi9q?=
 =?utf-8?B?eUxiQ1d3Ny9MTEZ5TmV6QmRmRGtPMTZRVkVjMW8vM0RIdzhGa2FHR2pLZ1M1?=
 =?utf-8?B?dEVESlR6NWl6N1BTblN0a2ozRnN4YVh0eHcyVGtMNnhRUmlBMWpyOCswR3VO?=
 =?utf-8?B?Z1dkRGV5akhVNTR0U0pwUW5nWThDQXdxZm5yN1k2a2NIemVwZ2hZQVo5R1Iz?=
 =?utf-8?B?czVGU0k5ZVVLTGlPVEJNQUN3M09ERGpwMzcvYjcyY3hkTnVrMmtYeUtraHY5?=
 =?utf-8?B?aEZkY1JacGJ0MVZGUm5SdS9ZMEp0Ulh0SDN6enVRbnl1YkV2SFFmVllOVFp4?=
 =?utf-8?B?eW1nS05YcEp1UkszNFYvTlhSVWVyRnUvWTNGS1FsMXVmSnZ1NUl0dzBJaDk4?=
 =?utf-8?B?dkt2ZW16QjVXSnZmZFpxdVNveUhxaGU1UkRjbldGS3VEWGtIcHRKdFREQVBu?=
 =?utf-8?B?UW5sZDZGNzlkZUNJbVpNZ1hsT1NJeENvck5UVWNJQnQ1UlVBMXV3N1NDOElU?=
 =?utf-8?B?OFV6SnJxYlZxZU5kY3BueWliUE04U0hPQkhFVjFwSllUdkorWnpJZm54MGMx?=
 =?utf-8?B?R01TL2hreGI4eVFFekFWdzZWMDljR0ZFZDhOcUxtOFBXYVMrMkV6V2xHaU1u?=
 =?utf-8?B?UWRxOFIyUklia1MyTHlRa1Bmc3l5NlRCTm5tTWZORER6WnZ0ajhDWEZCSjFC?=
 =?utf-8?B?YzNhZ3VEVWYvRzZhSTRHK3NTdVN0eWJaS0F3V3NjRmJSK1p3Q0JYUjMwOU1m?=
 =?utf-8?B?TEdrc25JK1ZzUGoyVFdjT3FOWDQ0RUpiWVRvTnFnWnRnWG1Fd3JDRFBmSEZ3?=
 =?utf-8?B?ZUg4clRPM0gwVnBWSzE1U3ZwMUpFMDFjT3YxRkIxT0hWVERzQ0xiSElVeDJh?=
 =?utf-8?B?SDN2WmJObXB4cS9uaDAyM0hQMnpDakFIN2R1U3VXZDdUcWc5K08zbTZQRmdy?=
 =?utf-8?B?N09VbjFuWDMvRTg5aTlzUEE2T29mUmQrVG15NWwwZUdpaHNCVzlTVVI5RnRL?=
 =?utf-8?B?NFpiOGtvYzF0SXVvY0Rwa0VJYXRWU2YybzY3by9hSlR3aVdnYnRaK3ZVaWZQ?=
 =?utf-8?B?c2ZKRmFCYWRVNGpMUnI4cTdDcEY4RTlhTUFXNmpVK0w5cDJMbXltdVhHczZF?=
 =?utf-8?B?VGxNUnE5aW9LNTFPRUZTdERlc3VhYm5VL2ExWE1XMDJqSmF3QUxoYW1iVnVC?=
 =?utf-8?B?eDNlSkhMZVNPdGEvNDlZbjRrNmxacVNNSG96dE90ZzJPZ2FCMGZ5Qkw1alVZ?=
 =?utf-8?Q?WrM9QJR3IFOe+Ejl9FVEVlrsi2P20k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXV3UmthMDJSSWQwcitDYk9YQko3QnY5aGRRT0NoMndZUDlOeS9McVE0SVdu?=
 =?utf-8?B?MnVhVGRxYTRlZGFpUk41NnpaeDM5NFhHVFJCYVBOTWordTU2OFd4cGlpWnM2?=
 =?utf-8?B?SXZzM3lsRFp0ZHRBbDg1aUhvV3l2eUw5bUlGNmFxREswREI1WFd6S1RxbGdj?=
 =?utf-8?B?emtMZ29TZVAwTTdkQnJpWWpxaUpuUTB6T09HbmZUMTh0Zi9lZnF5a2dnTG8x?=
 =?utf-8?B?a3RtVXZjTEd6c0U3L21WWmcvTEljMTE5eEVGc1pTZ0hZZTFFZUNxYmR0TzRB?=
 =?utf-8?B?UDIzOFJibWF3NWMxdXBEMGoyYkdERXZJWkEwUmJ5SEtBbGZxejlCKzJCbkpp?=
 =?utf-8?B?ODdiWlhCUmwySkZxb04zcVBaTVhoOG9rYUVlZG90V0NkcDJGRUhobzE2Um1F?=
 =?utf-8?B?MTFUMFM3MjZlZUJjcWVBVmRPRElBT0gwMllkZ0FxQUpEYm1wR1ljampyTnZU?=
 =?utf-8?B?Z0RXMzdqYkxheUNsbmVCSGxHUkNOVHJDMDFVY3VWRjhjaThJcHlpWEJuNHhv?=
 =?utf-8?B?R1RGanBjckZaKzFCTFFzZ2wzaCt5QkUvRlhpL2NOZzA5cE4rTVZKa2ZIT1ox?=
 =?utf-8?B?VUQzc3VFOTdkeG5rYm1tcFhLT09DY3N4VEUreE1BeS9MNllWYUlYMWJHM3ZD?=
 =?utf-8?B?WmRxK29xNWlGalZmd2dEaFNPM0IrS1Z3TnVzenU5ZGRwOGxKQ2Nsem5rTjhz?=
 =?utf-8?B?dnVDQWxTQ2NuK0ZzeEw4R0gvZ2hVV05uenlvMk5CVDdHTDNvN1ZwSWFOQndC?=
 =?utf-8?B?ODM0b1EralBjaitxUW5CQ0tNek15S2liV1BxVWwybGp4UWI4U29LOUR4anQ1?=
 =?utf-8?B?K0ViN09EWTkwL2xHNjNTbkhtWDU1SXhIbVh3SlJZMWVmam84SFA0Z1M5bHBo?=
 =?utf-8?B?c0dOckJkN2p6VzNTZEZpdlhOd0NQczBKUEFCL3J5RFZRQmNVcXZPdVM4Q09Q?=
 =?utf-8?B?Vld0YU1lQnloUkpXYVF3Um9EYmEyU21rYW56WjdUdEVDZC9UVlJNZ1RNNlps?=
 =?utf-8?B?dGJKcnFYckREK01Mam1DdnBLaGZjM0tZaHpsWHgxMXc3MjNMU2F6NkN4bkR6?=
 =?utf-8?B?NDZobVM0TnloaWNYQklMK0hMS3pYV0hCT1RmZjRBcCs0K0JkQm12alpoT3dX?=
 =?utf-8?B?ZnFpL2k0SFZGOGJJbElNbDNSMmJUYXZZVGdoSlJDR3dSQjNUOVNPNFhEcnNi?=
 =?utf-8?B?NFl6cUhLU2VuQ0tMcnh0S3g5T3ZlUmhaU0ZNRnNBa0JaZGszRk5PdmZCY0ND?=
 =?utf-8?B?Z3YwOE16aThvRkRoQkozTjRhNkQ1YWxFcUV2c0VYQUV6UTdLbVh4bXUvMnQr?=
 =?utf-8?B?cXFxV0dQb1dFVldiV2NTUGtEZHZid3kxbUwxY2VKcDBsZmhtc1RCUVE0MGEy?=
 =?utf-8?B?bnVqVzY0Rk54ZjQ1bTlvU1hzYmpNVTNlMHMvTzg5Y1FJa2pHVjBlSlRBY09r?=
 =?utf-8?B?WWlkcGtwRHpyTGNpKzNNVnpHUWEwaDRtTW4rRFZPR0VTV1d3WDhxZHI2eisy?=
 =?utf-8?B?cGRyaFlIaVgxbDk4b0ZKMDNhaHdjVHlzbktsR0xpeElBZFZqSitHc3hHUzVn?=
 =?utf-8?B?cWhUSVFTVitGL3JEOCtJSStlZnpkOFdCR2ZaSVhaRXc2aHEvSDBYdmZiZ1Y0?=
 =?utf-8?B?Tm1UZzJiQkJibEwyM01wNFVmUmdzRlIvWUtWUURSV21BY0VlUHlhK0d4Mk1X?=
 =?utf-8?B?MUVERExENC9ET2pWSzgvUTFCd01QNFpBRmNNeWZkVmE1Vm44ZjBaTnBwQjZ6?=
 =?utf-8?B?WEhkVVZIL0pNa3NWRHg0alVlQUpVQWIwQ2JjL2NnQmpMand1M0hBb3VkUmVB?=
 =?utf-8?B?SjFaOXBoQTJxdHUvRzNRWkNIOG9rbGpaZVBZaXJpR20ydlpSWk1naW5CQ0tp?=
 =?utf-8?B?bmkySnJDamwvZEdremFMWnNLbVBCYXUwNWVjZThkdFNZL1R6R3lyRVJ6OU95?=
 =?utf-8?B?NEJIMmduTkMxaVgxbHRrRjA4dUJwTzV4SHQrV1krUzQ0Zm1MMHBSTHRCU1Jy?=
 =?utf-8?B?bCs4V2QrQzFEU1VraXFPQkE3NVF1Zjc0UStQL2RFTVpqQ3ROK2MwYUYwWEJQ?=
 =?utf-8?B?azBVVTdHUHdzMmtBdE5nU0E1VEovZWo4anl6Z2ZRM0Z0WWdMTHZtcE9TOFN4?=
 =?utf-8?B?d2pqbWRzK0pKTjFWa2gwVGRHRkFzS1lPakF3VVREWm5VT29jMWxDZEUyQUsr?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------dDDpmgL1QYIZTOV6EvUJ6ALD"
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7393819-bc1d-40e9-65b5-08ddba237973
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 11:19:28.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQ2P50jAqKFlWCcaCf4XjjUeVoQbFnHhqBKgGUcU+AokukTuRU2/JvMAHNTg2OAY1fSqDJ4751TNjsOvfpopaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5608
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDAyNiBTYWx0ZWRfX+6C4BiayzvQE
 1qKIW0cjbvfgwvnSb4MKFPf4v+M1L71zFMcnwIsWMBdwlGZSo3gid6xDfCiyLT/IIe+lc7dUptY
 Z5QvzpDToNcgmOzLjtcmvOISAOCtbu+w7CRbEEWymBFBL4/nDxS48jNdtrDZaNFhWclfHDN8oiG
 imjuiMl979GysVcZLxKscU3bOap1xR4WyWGgEBv5fijshUglQBXY6SoHuNeR+LpAeOsyxSy+FdJ
 8JZcYgXMa1P82tDLm6Bs8aY5iuihSiHCKycTXerw1n6E4sX55OdKsuEG5RCXvYwiALnFYkAYLmM
 3eLySbsShAKBlidDFWWnTtny01sntC0r0QYPOMPYpUGfA758bLG2hwgxOYmEwep0vXFebK2hnWV
 yPsxkw61
X-Proofpoint-ORIG-GUID: RQhkrI3vp1F30hLGLcJiLhrGcc2nJqPf
X-Authority-Analysis: v=2.4 cv=LpiSymdc c=1 sm=1 tr=0 ts=68666744 cx=c_pps
 a=CcAh+5gGph/wmZbTqc6Oig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=NgoYpvdbvlAA:10 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=kSjZZ3W72rST0Bqgd50A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=7Ju0TyEyhcsPJHHkZegA:9 a=FfaGCDsud1wA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: RQhkrI3vp1F30hLGLcJiLhrGcc2nJqPf

--------------dDDpmgL1QYIZTOV6EvUJ6ALD
Content-Type: multipart/mixed; boundary="------------4ZC8DXk7gtp0vIwQYyKyzITQ";
 protected-headers="v1"
From: Matt Coster <matt.coster@imgtec.com>
To: linux-sparse@vger.kernel.org
Message-ID: <ea14a74d-2da3-480e-bb84-33904aaeb10b@imgtec.com>
Subject: [BUG] Alignment of structure members does not always propagate

--------------4ZC8DXk7gtp0vIwQYyKyzITQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I started investigating this in response to [1], where it appears an
aligned attribute on a structure member is not being propagated out to
the containing structure by Sparse.

Removing the explicit alignment on the containing structure appears to
resolve this issue, suggesting to me that Sparse *can* correctly
evaluate the overall structure alignment, but that this value is
overridden by the explicit alignment attribute rather than (correctly)
being coerced upwards.

Here's a minimal reproduction, which compiles just fine with gcc/clang
but fails both assertions with Sparse (which considers the "correct"
size and alignment to be 8).

   struct outer_struct {
   	int member __attribute__((__aligned__(64)));
   } __attribute__((__aligned__(8)));

   _Static_assert(sizeof(struct outer_struct) =3D=3D 64, "bad size");
   _Static_assert(_Alignof(struct outer_struct) =3D=3D 64, "bad align");

I don't really have time myself to dig into this any further, but I
wanted to share what I'd discovered so far in case somebody far more
knowledgeable than myself can easily identify the issue within Sparse.

Cheers,
Matt

[1]: https://lore.kernel.org/r/20250606-sprase-reasoning-comments-v1-1-43=
3c0ff11a09@imgtec.com

--=20
Matt Coster
E: matt.coster@imgtec.com

--------------4ZC8DXk7gtp0vIwQYyKyzITQ--

--------------dDDpmgL1QYIZTOV6EvUJ6ALD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCaGZnPwUDAAAAAAAKCRB5vBnz2d5qsMHa
AQDZILpS031Yu319GxGSnlCKBwgnoveuFd2/r1+PAgsNSAD6ArlwbVktdt9bNnZeMJS+eH0oHt92
8pTSyE7pYwINugk=
=jPNQ
-----END PGP SIGNATURE-----

--------------dDDpmgL1QYIZTOV6EvUJ6ALD--
