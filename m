Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B53806B2
	for <linux-sparse@vger.kernel.org>; Mon,  9 Feb 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654319; cv=none; b=PYuPvchHb1UwdtFQ4WU+KkuWJKAXqOC8xVEj88WIsCNRmgf6ii0eyulvopjj8Sv1QQUchwwg5KIl3kDJIj0bV8a8fnG6LN3b6WOIxDlS6qxr/RZ4oRZTXlGVGNvKfjzK2Qtw5deWFKq7CcmReatkW9u3fBBN5ZBohcOoIHzHBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654319; c=relaxed/simple;
	bh=wQrCT4ghZN0EEzpG9+Q4sWjE5HsBkLDdjGt671NAGC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFHcqXF8dn177Buzily/kDip9stX+jdemdb1v8fY5sn30JqN2v5cGlEj5JYtcXSFZgcfg71uJeUa75W2nUMAQq5GwzwydGsw5gogzQE4+XB+WnqES5KNcOqflII5UqhmhJg2RvYLilzHJn7lXnedUFHuN1HbJuE3QBqFhgVPx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BIOqPsrB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=euzS95eo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIOqPsrB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="euzS95eo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Akiaa3699863
	for <linux-sparse@vger.kernel.org>; Mon, 9 Feb 2026 16:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ELi+j/l9b24+CYTkb7upw2voI86VxtQb/pJo4BkLiwo=; b=BIOqPsrB/UisBGdi
	EBxxgKYaI4zT5ItnfQMmlwllASnNDaanTqtDcG82kcuQNcLXvhBaVdQ3hULz137n
	dgzTe7kUmlPzecHKpUfAOUaWlPx6VKjEq2d1V0Dhse7t6LbzBrQiBPWlkr87dx6d
	oKvPzJBp29XPWdwHwtMOytSA8aQp/tul511jJ7mJ/CaBQ3hPzOaG5+cmXNASUJZ4
	bipw48cf+qCUd9AeZKfSHTlfFF1HDQgGyIXQI9Qt8421muN2YsgJa7tDXyyOUaoq
	UjXAYE40gDislNYa4VOx4eZzAZ8xVTV79QJn8nkoxXA2myloKVUKuk8QaAen3qzQ
	ktaM5Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4m93t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sparse@vger.kernel.org>; Mon, 09 Feb 2026 16:25:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b7ef896edcso13791996eec.0
        for <linux-sparse@vger.kernel.org>; Mon, 09 Feb 2026 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770654317; x=1771259117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELi+j/l9b24+CYTkb7upw2voI86VxtQb/pJo4BkLiwo=;
        b=euzS95eogUHVbBAZt6+A3dr8LkycsPZycb+y+QYlrnPUqDUKZHHT/i6awGtma/pf73
         PWNQo8l4SSwAWjB3ccf1KJ/MT0NZnnvONvLMnSTRyA7YbSyeDvd7NRlxotC1CooouN6w
         kfBw78VFzzFbv0E8PwFVrqwXoM6Kyaim9rz9XjDaOE9mGeyWgo1coSY6MMnlW+VVEFXg
         sbZwOEj6OGCNgU5wXw2Xt2BVZilds0bRvhry29HrB7m3CiuEVveONpCL+Kn6U+akZqnN
         Y3VteSvYUutbsahbibV0F3WmZOqtxYPvGIwEP/keaaQAqqYHYnlb/l0j1PC7IDcoGyJG
         Cp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770654317; x=1771259117;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELi+j/l9b24+CYTkb7upw2voI86VxtQb/pJo4BkLiwo=;
        b=As3DK6haaEhfWMMe6JsYjmLY5QxAI3FIODImEffsnJFF3vouoBwLxX7E89twpDwTHQ
         /3uaMZQf5D3cM7B+4T0oSHY7TlWJqu1LwHg1t8XcACtnt/XnV1zoIS2nr3fb0dF9j+CC
         WMdKX75EGIfp1tgZNKzJiz3R8NqG2wFWxds2ZPUa000Pprbns5sakj+FMfDZpVhHR9h7
         PaswoAOpNW/w9AzMvMFZrF3VYTLlNkGYNnLYH0KjEIApw+jDxgwXyTm/8ChfbJcNH6pV
         VUx4aO+gfWfG+lrGnI+10Q8FEFbEJ3I6QyjkLtIuRmARClqS2HutaxDpBQwrPnmvNTQe
         zPHw==
X-Gm-Message-State: AOJu0YyYio8lHr7BgclDrUAqSVCnmqhvS7Wyyu3JgEzckByVG4uzw7eb
	jOSku0SI7Tft+4Ie8x9uCnem9miFfFBZS/wiR/TWLJiazX+ZGdbBJaZ8DUqVqeMUIu6ZRbMNzK9
	rnHsHT6O4OiJzkpxEe/DvSZR+5j3+3lKD7etHiQuCkm0CAaxCdB9HFLi3aJG52mTSC0Pv7AT3oE
	I=
X-Gm-Gg: AZuq6aLY9US0vopjgrzHkAYfdLPUiei0VXeS7PeFBb9MHMQ8ADb+4rwf14S6iUmiptS
	Ywx5izYqSkHI2D3w6jgV5tTvRFXz/UG+PGBuF0XR7OLE3tB/Ptt4Gk8HoueUsp1U9lPIcx5ybpS
	GD/OV6IVLW8QulFK+7qnKY8BEgPrpU2ZEEGbNGnTANw+GP3UaVnCR4rUltk72viWMeIr7pTTUnn
	jPhrHMlPCVdU2ObxnoqEjQcAtobFkdEJ2LwPj7JL4gEImrOjg1DVk5IQxZnNyVDrBj3jwx9nVOo
	AAYWbIWEDErqwjY3+32lDdw5KFgpc+KKB7/VccmjHnWT5uJxvbL1/NB3/jZKftQN4pEbQIzPZ1b
	LdQbAk7JGugt85x+EI0lXBD6l2Uabhw60yqd4PdnR5cSgTk+aT9cTqoht3Q==
X-Received: by 2002:a05:7301:3c9b:b0:2ba:6f02:2936 with SMTP id 5a478bee46e88-2ba6f023ebcmr1644885eec.20.1770654315640;
        Mon, 09 Feb 2026 08:25:15 -0800 (PST)
X-Received: by 2002:a05:7301:3c9b:b0:2ba:6f02:2936 with SMTP id 5a478bee46e88-2ba6f023ebcmr1644866eec.20.1770654314760;
        Mon, 09 Feb 2026 08:25:14 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b8647bd6casm6659855eec.7.2026.02.09.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 08:25:14 -0800 (PST)
Message-ID: <c57d33cc-dab1-4846-9c51-c358710a01c9@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 08:25:13 -0800
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issue with _Static_assert and __builtin()s
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org
References: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>
 <aV9DhtIM7Z5ZmJRz@stanley.mountain>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aV9DhtIM7Z5ZmJRz@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0sNrTGjtFUiIpSCxWNAgJ_hNEgNSl05K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzOCBTYWx0ZWRfX3fdjIsL84LMN
 j+Nf8mfoKjvC0BcNwYv3Y5GZ6Mi6s+LSFYxpxhk8kkp0WvkSsbkkIUUfNipOc8wDTE6Nzmk00tY
 uW/Mc67QcbKkd4WB48+gxdL3DSLBW8Ap1rYyu5Ffu2TFhOrPu2v0Xs2URNHA4ASZ3GnqAEYZYVf
 Lw2KLrE20OrX7VZTPrzLX9zHu0a+YhelyjGnD3Nsxg3uCQwzU+2e1syp1Hm3j8wJYmt0WtDff0x
 5EIzBzuT3cyNNyhcOuxhymSFIAsU18+K7+vDkn2D00jgo9CNNIvjI4Dwdq1p1kzwAQsiOswuid2
 W5tLopx0hwL1yrx7Ju1OJwaQTdWQ0gLr9DGbjF11rESRJSg/0ZMLDgH5D+v0neFEOuN3Czie0H0
 Aitvm+T9JyIpp96LxnOwW0GTwNEHqrDConKH3SkMQYHL87p1LEfzYzCgd8xMxGX+enidQvifL5a
 PSZEMlN9FeofjH1dXmQ==
X-Proofpoint-ORIG-GUID: 0sNrTGjtFUiIpSCxWNAgJ_hNEgNSl05K
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=698a0a6e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=wS6F8ZFaQwFl131ivCUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090138

On 1/7/26 21:41, Dan Carpenter wrote:
> On Wed, Jan 07, 2026 at 07:41:45PM +0000, Ben Dooks wrote:
>> So I am looking at why the Linux kernel's check for nul characters
>> in strings is causing errors out of sparse.
>>
>> EG:
>> drivers/md/dm.c:3813:1: error: bad constant expression
>> drivers/md/dm.c:3814:1: error: bad constant expression
>> drivers/md/dm.c:3816:1: error: bad constant expression
>> drivers/md/dm.c:3817:1: error: bad constant expression
>>
>> I've tracked it down to the sizeof(str) - 1 == __builtin_strlen(str)
>> failing to be a good constant expression...
>>
>> This is an example of the assert which isn't working:
>>
>> _Static_assert(sizeof("moo") - 1 == __builtin_strlen("moo"), "nul!");
>>
>> This does at least get past w/o warnings
>> _Static_assert(__builtin_types_compatible_p(int, int), "doh!");
>>
>> I've had a go at updating builtin.c to deal with __builtin_strlen()
>> for a string constant (attached) but that's just changing the
>> output to "error: bad integer constant expression" so not sure
>> what I've missed here.
>>
> 
> Al has a fix for that.
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992

Al: Will you be contributing this fix (and perhaps the rest of your
accumulated changes) to linux-sparse?

/jeff
