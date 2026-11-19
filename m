Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120659;
	b=wA27yiLaeu+0iTDihW8Pv2IzxIj4LYogPzg8s7dzEsiKDAumV1Ywkmd2TRFY54BOv4BE
	 L6x/gWQW/o05Au+7iMuTIEPFc77ecyW77R4afoFTd1xUbTTxu6DMSjR7pXyp3MypuIE9P
	 fNfz3DUnXP8i03f+VN/SRfqJLVF0wslqUJUV5mvI4osAc9EUAPeVaCPv5oOZ0Ai4Qhw7N
	 W1vaj9+UQRiFsaZa9QW5apOzmRScjKXgmNNUOJv0Eg3ReWegO+3RnhwxS2YswmalmJUos
	 x1dK15s82INa+gdyWZJGa8+7k7JELxTuRjD83B2QtT3Le5FaImA9j6TfyVQJwSupzpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120659;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=usLGfKw7WyOvGpGSAar9pbuobCttFvRZ/n185IzXhe0=;
	b=I7jEV+ZMR9Lsx8AlFWtQh5c/qzZX4J6CJR2Rn/A+L/WURtNYrqcOjIUZwMgGsURCgghR
	 Hv7SK2COtcgnKsYFGIxHQFQIiG+VXwj/3Mo7DQQlRC79nWdI1ZMYuOj/9mWg65r0bISrD
	 rAlRslh9py97GtUbXo00XbxiO77sL/IGwQOH1Po2w+YmLRxYgWebNnciOFIgAjKXEmkvA
	 zA931HM9mq6pVJyEClNfB89GmvXGfILppE9ydVissVvLW7eE85HxitOANhxxEjVS0G4Bo
	 hYkgpgcRv39wvlqXlE8bijx/y4W/ApuQ6uyMgSnqChrUgeok321qd/GhXFf8IiOlnYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aHR2SqPZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE56074303;
	Thu, 19 Nov 2026 20:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CE56074303
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aHR2SqPZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMbU4xYLxQqgLGPh+i4QWiZ6YDXyA0GgEwx8k1VB+WIeMTnM2EwKMrUuFsdGa3HJJq2GycVaiTkQF1/YdjuO783aSnNiumHC8bhZSngMv24+o1VPNfrdoY+B4PBeYecleBn8lxsT8WLhm3Y4RA0tLKzzvKbM8WCROcId1w0Dj3mhkwQ5UAi30jWxEsfBov+6KbRX/L8jTREpiaUDUlM4kDkk3pGa3PWYEoLyKiG7ahZlmsrl2H3Pzyb5SNFaeheyf7u3Q1JT8bBjtf3phZ6dNUOWNt6pgQQLtr/HcxVJbTgTV3UChwjseBi0bJZZCdYceojFkc8sHI1+ZUjBzNVXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usLGfKw7WyOvGpGSAar9pbuobCttFvRZ/n185IzXhe0=;
 b=YItTTfctMUBjmHBP9wMxx3NbpflL/C3OjrGLioS6nnaGsaYoqZSvQHFxcE3WXf893jcXpbSVWDZtV6BEjoAexTg90+LlFC87icRPvDXxvzSsGWlUEahc0X3ByYf8dcB1ApJAgwFEfbc+rpXsEtbetPACgZn1DxE3yECAcVMSfjcOsskKOGENeHfd4CKgLez21qtKUzwpO5ttby/EEQ2yBnSxl74B424iJqbWwJi1Zt9RhRnDziKfZsALP144andPzXG4atDcuVwS50ce0/oIkbZoxd30DMt5mr0NN3T5uxs8EbfhLvgDIYidoMQ4M7aFkiBhZrgAGNtqyoNlEXA/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usLGfKw7WyOvGpGSAar9pbuobCttFvRZ/n185IzXhe0=;
 b=aHR2SqPZ8XXPQ3Hwb/mDVNKiogB//OK2vi9q7bKGdUCi2L+tZPtWvtAO9vdHgcHEz1Zx1wPUAiQ86Al32/qBsj6o6PUEtBlXbJESoeaos5lnADSnopeBFheFQ+JbhYwgO/ik3gTB5kjSWw2avQwSt8i3Q/pr7Xpl0GoJGEg1FJ+izCN0diBLXgtvCi9pQj95BpWJ0vyy8hYUdA/TQtE6aDuvhSNPpl0hUlbNjxT8NPi9u+RU0voqvfpOanqj6dYyte3DlWGUJotwn/IFejNp1Mktqr374z2Tz81EuxarAtOt9Iw2YDswS6cH9XQNeY7UN9pvRIbwFk4M4FypvJamCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV1PR12MB999305.namprd12.prod.outlook.com (2603:10b6:408:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:37:36 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 20:37:36 +0000
Date: Thu, 19 Nov 2026 15:37:33 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <av9eAde6AKlAKWaH@yury>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|LV1PR12MB999305:EE_
X-MS-Office365-Filtering-Correlation-Id: c96b7528-ac31-42c3-6d9a-08df467cf20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|10070799003|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261028144727099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	m0k58nNP2nTQLJrBIh0eezTTZdGaCf86wSxAIi2WcEKH1l1YXiGaEV1voY84th1ggeB49NrHETONTsnx8mPvjDCjvabLJ4IeJOqgZpCRFP95R5wzyasEY6lXCqGxqIa8JhzZMEU1z0lUYeKczuMkFGU68k9yFE6PDiL/Kxjx/XPTTZkvHDeR+eUXXSJpZdkwuiM7oB4iAYHYGklU82LRDO54q6fB5m78O8G9trFnn1Q6L/a6By6WEFhHi8ejlZlJrTa0YZz1lV6gPH2foHqspGNi1Fq8xOkJ/0xcc1EUkmGmAUZ26o8TAGpjoJ0d/uoyjr+cMTx3ISNRdlPPZnBiqq/AOCzYqxc5hAOd+zYOVaBWcKOVgbtYU62bsH2MK7HKLwv1qPTZmudmk8wRH746qwDUqHSvMkYm/Vsc4GfXjF9HPsj/ixPtrcJwRycVgxZWU5odBGnuKFiivsOVwxIaHm3o2ZfhJXMqR2VF3fWcg11pEJs+1bwmS5sMgrec6hqt9W79+w0ehvI6OJQ5UFons7EkchVN8XJa3vauXgvBZRjhaaN9SAJ90exDspU4VMXA+G/WzUyGi2lLfqKflFs89VpmwtxMCx0tJ2yyT/NJvn8xAD4eYDemN9cbR0EU60eSXKXAD+AJpVdIEdpPLnPak944ANpXfa6osFc9pMT3HBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWRYVGUrN2VLNk5TYXBVZlpjTkE4Q0dSQ0FlSTNxZ2VJd281eWw2MGJQbUx6?=
 =?utf-8?B?UmUybVVMcThPZ3EvaDNQM29IdmR1ZEV2a0o0NVh3RzdJT3pmT1VkS2JFTkFS?=
 =?utf-8?B?cGk0dElUck5qWm1ISnhXeTZEUWVhSndreVVpeWc5WmtqZ1BnZ2IyV2huVkFk?=
 =?utf-8?B?cnBoKzNYODdmTFBVL3MyK0RjQlYyRldFWDVLRC96eGs0UHY2RjM3SENkT0hv?=
 =?utf-8?B?QkJKRVJhYUdvL0wvSnBmN0Jva3NocVUwRGF2Z0NIb2djd2VMU09iZ1MzQXJw?=
 =?utf-8?B?ZFUvTmpZZmZzeWRMYVlhKzhEZXA5Ym5DdVV6K0prRmRYdE1qUjFHd3I0QUo3?=
 =?utf-8?B?aFJIa3pHQVpSNlM2cmprYkRKODlqUHdnUkhFVU9rUEQrM1ZVNy91a2RXZTQy?=
 =?utf-8?B?c2lpRUFBL2lKN201eSsycng4VWJhMW9ZMUVEVEdQUTk4VHplL2ZJY0xaWVR2?=
 =?utf-8?B?MG12YUVDSUp5a2htRFFZajZmK01RQlFZUHZIVG5CY0lEdlFYRXNTeXFWbi9p?=
 =?utf-8?B?WUhtNzBWRVRIQzhDVllxQzBrZjk4RmxRN2ZKQTNZc0VHSEM5OGpUN3NidXRj?=
 =?utf-8?B?eTlJOHBPWXo0T2VvZ2pIS1BWY2hlRlJpVitKWTQxR0d1VXZJc2NnZkR1cDQ4?=
 =?utf-8?B?WmF1SlZhSitxRWlTeTI5cWkvTlhBd1ZzVHdGVVhFMjRVU05lUW9EaHFpK3F5?=
 =?utf-8?B?bWI3c2VVNXBLUUFFWHZYQStZc2tqM09sRG1ESDNBdFRsZ2VRa0tGS3ptcFA3?=
 =?utf-8?B?ZjlvcFNUdkxKb1hETlBaTllOMjIwLzdlbUR4V1NLc2ZIZ01MWlIzdFJmNysx?=
 =?utf-8?B?VzVOMTJ0N1QvZmJHRi9zaVBSNVBoNjJ5dUhvc1UycldOeVl6L3FOSVdwVmRV?=
 =?utf-8?B?aHEwUEl1ZzR5bS9KMVRzWXB0UTVZQ1BvenROQU1iTHV4Mm9nSExJNHBLNGFU?=
 =?utf-8?B?Sml1V29qeXNFd2wwdXVVVDlMUFBpQ2VMeElNemVQRFl2dDNIMjltMFdaR0Fw?=
 =?utf-8?B?Snh5N3BZV0NBWGs5K05pQzUxQWxJTTdhUkhIYUorVHBybE5yZEwrZ2kxVk1P?=
 =?utf-8?B?UnhYTWZjd3ZaWEU5LzJxWHVHeHRiWmRNYTBua0dYRUFPNmRNd3VWSUpaNE1U?=
 =?utf-8?B?NjRTeFRUUjRUZVB6bHFZczFsUk5VdStybXgwRFcxSHBzSCt4L0lzVTY5bGpW?=
 =?utf-8?B?VUdObDBuejNJUFZ6ZUdoajROLytNTlRreEJwWU9aeFpyRTNCaGk4UUNCMjZ0?=
 =?utf-8?B?UlU5VEdtVHhsR2F0Nm10WisvT0I5MlhUUkFYV2FUZlp3bXFsWXhqbjZaQ2xF?=
 =?utf-8?B?T3BxTWRiT1pFWGRkYXdxdkJCVjFPVTFyejFQSEsxcHV1c2FHUkE0NzhUWWg4?=
 =?utf-8?B?RTBLYVpwNTdoY3F4Y08wUER3QVVNK1NDeTk4eVRQNm16K1EvVS9EYU5MRElV?=
 =?utf-8?B?SXZLcUZhSG5yb202cFB4N08wTC9DT3B2b0pidzM4MnNQV3NhSHBwZkFKWGI1?=
 =?utf-8?B?dUdWdDlieFVVc1FJKzFMdjFSZTRucnRTR1d3QVJkM0xNV1FTZ3owR0J2TlU2?=
 =?utf-8?B?ZTFGRFBuSGZFRDlCeUtqdHQwZlg0cWdDRXZqOW1wRnE0OExCcktmNHJKKy9T?=
 =?utf-8?B?U282U2NSYS85aXVMa21iS2hmK3NTN2cvWUw5REUyZVU1ODlRU01tTFhYMmdl?=
 =?utf-8?B?TXI1WDhtL3Fva1RHb3BkSXpyRlpyMGk4elQ0MzkzdzhXdnZnYTFTTXVZeXg5?=
 =?utf-8?B?RVh1Ly9rSklwTUZuYXRhWDRiM2tlMnJQc01KRnV6TlVxdmllak80Z0crUElR?=
 =?utf-8?B?c21VQkpERXVTT2U4elZUbGl1azROT1NkaXhpYVlxL201enUzcngrYW5Yc3Qz?=
 =?utf-8?B?aHN1Tlh6Vk83Q0RlL3FUNEI1anAwa3VOSGxKcFB4VndDZlJoUjlQNVVTaEZk?=
 =?utf-8?B?a0ZOampLRHppaEVNd0NJSUtPLzFtbWs3UDZuRzhxZmpCWHNLS2JnWGFtemJu?=
 =?utf-8?B?L2lWL2xYbkV3blo0SDEwLzEraGtIQ0l6cGlZRktkMGQvakl2SXlBZndhRi9E?=
 =?utf-8?B?Qk5wYjJrc3dSM1VEMlpWZ2N3RitSU0JFU3QwMzhvUkVsWjBtK3Q5NTV4YTFu?=
 =?utf-8?B?WmljY0ZiK0lEZjZ4NDQveTFvYWxjT3U1OUsvZFRMRFl3YVQwWklYeVZnS2Jo?=
 =?utf-8?B?K041ZGlEZ05ick9KWlkveUlZWG9kcGhCZUt2emprRjR5RExiOGhCRWQvTVZZ?=
 =?utf-8?B?dStFZ3Z5ZFBQc1RnT28zSk8zU083SDJoWlB4N282WWVKK3UxWGhmdGxTdFEw?=
 =?utf-8?B?aWZLMDMxWG5YQ0NpSG1QRHh0MGlmM2NpaDVmZW9mZWpKWHpsVFRRbWxFM0R6?=
 =?utf-8?Q?fW7JbKttivMDKPnEZScb76l6wnhwl+lNfcFLE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96b7528-ac31-42c3-6d9a-08df467cf20f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:37:36.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA1TZh2T3g4B7roiQ6uvlN3909LCNkL37nL/qJ0ggw7XfOcBIFGDPkNRpRJ+XUGr0/D6Sn/ucElkhMe/o4AfQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999305

Hi Andy!

+ sparse people.

On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:
> While compiling ad4691.c I have noticed the following warnings:
> 
>   drivers/iio/adc/ad4691.c: note: in included file:
>   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
>   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> 
> Since the bitmap_read() is called with statically define 'start',
> the 'space' local variable becomes equal to BITS_PER_LONG, or 64 on
> 64-bit machines. The 'nbits' parameter is coming from the run-time
> defined value. Static analyser doesn't see that the right shift
> by 64-bit can't happen — the space >= nbits check guards that.
> While Jonathan put it as false positive [1], we still can give a hint
> to it without growing in the code (`bloat-o-meter` for above mentioned
> driver shows no difference in size). So this is what this change does.

Jonathan put it right.

If the analyzer (assuming sparse?) throws false positives, we don't
need to change the kernel. This is simply a wrong motivation. We need
to improve sparse instead.

Otherwise, the kernel will become a collection of hacks for various
poorly written tools. Let's do it the other way, please.

> For completeness, bitmap_write() is also refactored in the similar manner.
> I have also checked a few users of it and `bloat-o-meter` showed no change.
> 
> Link: https://lore.kernel.org/r/20260531111528.32697d1f@jic23-huawei [1]
> Fixes: 63c15822b8dd ("lib/bitmap: add bitmap_{read,write}()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap.h | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index adafbcf2016b..f331cf06130d 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -846,7 +846,7 @@ unsigned long bitmap_read(const unsigned long *map, unsigned long start, unsigne
>  	if (unlikely(!nbits || nbits > BITS_PER_LONG))
>  		return 0;
>  
> -	if (space >= nbits)
> +	if (space >= nbits || offset == 0)
>  		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);

So, doubling the number of conditions, and the new one duplicates the
existing check. This version suppresses sparse false positive:

        if (offset <= BITS_PER_LONG - nbits)

And even with that I'm not sure we need to touch the kernel to make
sparse or whatever else tool happy...

>  	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> @@ -874,25 +874,23 @@ void bitmap_write(unsigned long *map, unsigned long value,
>  		  unsigned long start, unsigned long nbits)
>  {
>  	size_t index;
> -	unsigned long offset;
> -	unsigned long space;
> -	unsigned long mask;
> -	bool fit;
> +	unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long space = BITS_PER_LONG - offset;
>  
>  	if (unlikely(!nbits || nbits > BITS_PER_LONG))
>  		return;

Initialization of local variables before the sanity check
may become useless waste of cycles if this sanity fails.

This is also not necessarily needed for sparse happiness,
I guess... Let's keep the patch minimal?

> -	mask = BITMAP_LAST_WORD_MASK(nbits);
> -	value &= mask;
> -	offset = start % BITS_PER_LONG;
> -	space = BITS_PER_LONG - offset;
> -	fit = space >= nbits;

I don't like this 'fit' thing, and would like to drop it. But
let's find a better motivation to do that?

Thanks,
Yury

> +	value &= BITMAP_LAST_WORD_MASK(nbits);
>  	index = BIT_WORD(start);
>  
> -	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
> -	map[index] |= value << offset;
> -	if (fit)
> +	if (space >= nbits || offset == 0) {
> +		map[index] &= ~(BITMAP_LAST_WORD_MASK(nbits) << offset);
> +		map[index] |= value << offset;
>  		return;
> +	}
> +
> +	map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +	map[index] |= value << offset;
>  
>  	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>  	map[index + 1] |= (value >> space);
> -- 
> 2.50.1
