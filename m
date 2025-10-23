Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F1330B2F
	for <linux-sparse@vger.kernel.org>; Thu, 23 Oct 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231076; cv=none; b=p0gP/I3Bt+KoEVg6LCNUi0pOFZJ7LHDSa6kfGQ2GnlR5oJIFTvZw2uTGg1yqJRUUI3xAUpRyoAbv6wg4aDqF9T6s7whkDJUkTnTE36RfYC+DzZEr5uv5YGcPOmA9R0Nm8wtIvD9ol3hul6gOepWRHLbvrdbLqNce5Iejg3EmxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231076; c=relaxed/simple;
	bh=nTCm0E0DZEOw4bT7skogqqCxkYln9uhSiEPtufpsYKY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=bH++Qb8iXuD/45BBWDtxNwOzcu4eLXethfhrdSaatejoWWSQQ50OcVP7Kr1hR0AOWrpcWN8E2zVEhEf2C33gEkcl1sWPzW3s5p9dZCoh3jBe1KO02j75zIGTz7jmLFWHCt/dQi310X18PTY9+37/Y6TWM9RgVzLeh72lEOhsTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/1zdoR0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/1zdoR0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NE1EwI031877
	for <linux-sparse@vger.kernel.org>; Thu, 23 Oct 2025 14:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nTCm0E0DZEOw4bT7skogqq
	CxkYln9uhSiEPtufpsYKY=; b=L/1zdoR0nzKChbSOBfI11NXGJYfTYc2yVUaXun
	UsqK4nhA2hk/su05B+O/CtUt+IuKCHaw0Fs11zqaTJp0VZQEKDWCI3NRhf+MWrO6
	4U7oDpUCJmRX2SNTSeX3WaJyqN6RL867/HtBomi5k+q12KIkB65R//Emg83uoQbw
	cAJHYWB0thVKBzdUg86d2aEiYoRF7o5d86s6/PTeTHLlToaEkFyFzSaAIU4abcm5
	D8dN+00UkFLW+is2J2HUr1Ols+MEBe0J9xRHlT+VGEtLrQNHNnb4ahbFIblOhcQJ
	v7eNhRktlpIrA3FHNXVWyfIhJ4EeJlnutls1i1giLkSQ+YOQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge8sh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-sparse@vger.kernel.org>; Thu, 23 Oct 2025 14:51:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78108268ea3so1932753b3a.1
        for <linux-sparse@vger.kernel.org>; Thu, 23 Oct 2025 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231072; x=1761835872;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTCm0E0DZEOw4bT7skogqqCxkYln9uhSiEPtufpsYKY=;
        b=sXq4h2wk6yWsHpnSG9LgIlxZzyRTSgeFEOFfL1sO3gw4rNvZN6Gjm60R9GOYFwIAbs
         dvAg9UHmXZapnoo5M/SejaYYpRMWi+eD7ntBrexSyRrm7bvxOMzL+CoKY68+eJbCK9GW
         WnNv4uNUkkyD0+ENJegfgxgLmEex1KG+DDqxrJWviUAonOjJRgv3ADHknbEahB4eZOO8
         Ps5D0SzlNhKGgMvvufeJAhryzriHagjxyalcZo5gRqr7HTJs3Alu9ug3a51wyElOS4Tw
         k3Ua7M4vNn2K7JR8vO76/Q1s7YCKIL1bBda5sos0A3/fB9vS1eEjdoIEwA9V/0r7QIPm
         wo9A==
X-Gm-Message-State: AOJu0YzC46pXB1jJeDB70Hax5R7XawGzZhiAqgjj9IV3ZTTUmvUkr29A
	znTBVRgUOKU6vLtg2vQt8QY2rUCLIgo0xGtrj8rHks7oHQpEvBx04duhW/0+moNUdxFT4BvmMoA
	cJ8oz2LEM38Lv9yM9Bc+/KKKKt6SmHj5f1irY2lo1e38Fx+j8EWUlK6DJc1m0YVib9r3/fHK4ya
	Y=
X-Gm-Gg: ASbGncvLrRqaGb/YPQ6XrDWqatsOEWra/TIpp0BN2LdM1U4BIV48rxw5i2mQarFqLrc
	BF+mKru/URxTa5MeEJg+MhGfquGPJbBA/sEAH5KT+c3NMlKX2h8ACMi5wUz7bx0+JEbJGqYnJkt
	QblOPoUfYgleLTGa2ze9QOCMoL3wibwHwOXBBAeBGZVSA68MKMeo69Eru6PHo4YJtyLG6fCljpp
	7CEF5+6nfD5cy85U9z0cm+VTvxtuOvxmBYOZl4FsMkhTm/aTaIAGCrWl0m1XyZZRuXtUulcOxBQ
	M/WWZprRpNKS5jZo+Bf2ppFmAnDjMcz6X0yALNiT4IRxr87Gz/ZRuZnReiW8i6YCii6/CbDRmvn
	8nw4bIeWu8SNUyAMb2WICx3nJp9fU4qcUfKDk9kxzdB/Wmqc7N8PFG5ri5No=
X-Received: by 2002:a05:6300:6141:b0:334:98bd:4520 with SMTP id adf61e73a8af0-33b68abc66bmr7983560637.12.1761231071984;
        Thu, 23 Oct 2025 07:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjYteMI/fKDfe3PsFg3JdwCyweVgkVyz6Gs/nneMcRLDPxCcWHB0xwF9Tfecaj6oyZtJxGTQ==
X-Received: by 2002:a05:6300:6141:b0:334:98bd:4520 with SMTP id adf61e73a8af0-33b68abc66bmr7983519637.12.1761231071435;
        Thu, 23 Oct 2025 07:51:11 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c05165sm2299203a12.13.2025.10.23.07.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:51:11 -0700 (PDT)
Message-ID: <54b7bc6c-8e30-4924-b700-bcb87b79be5a@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 07:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
To: linux-sparse@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Will sparse ever work correctly with guard?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX7OjYAOaNVjZN
 b4z45MY3XaS030+0cORmmkkxI9CU5ebROy2SBd1lOevCnTENg57ONsDjoTytbCnFAqYSTOZd4bQ
 /YBhgyFyj7/lGBTkSR6tW0uhKQdsxJ3JgSdRNgnuVJCEXSEDG8sXLF1msnte2PIf/RL/CU3lxid
 VfdQk2CcY87RfuHvjS364Ohal1gjDPDIKJrF67ADqQUfFxH+dQePAaJtlEyJhBAOvGSbdcbRPPW
 qP89iFBhUMvZNwl1LZ/c75c9clwamtohvoH1KDLJhMaxA+sdXqDM7nm96X5BAbth31GZd75S0fj
 gUE5VJ5XMThcfzqDbH25Ki0vaU1uIhI57762VE6H02mT87E8vGMa6u4ZpsfrwlX3RHP9A0g2BhM
 zK3o2bdvE0Z6QXBEFdLsJslr3MKWaw==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa40e1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=3lU2tRPfHO6n-GZdqYUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: qgL-B-ghIVianv79vUWQxAb4g61cN84t
X-Proofpoint-ORIG-GUID: qgL-B-ghIVianv79vUWQxAb4g61cN84t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

In code I maintain there are places where we are now trying to use guard to
cleanup locks. But 'make W=1 C=1' is complaining:

warning: context imbalance in '<function>' - wrong count at exit

And lore shows this is not a new complaint:
[PATCH v2] parse: handle __cleanup__ attribute
https://lore.kernel.org/all/Zag2fYsyJDtDR7a6@google.com/

For some reason scoped_guard doesn't have this issue:
Re: [PATCH v1 3/3] cgroup: add lock guard support for others
https://lore.kernel.org/all/722C5824-0381-4E43-B8AE-AE8503CFF51E@gmail.com/

But using scoped_guard then requires an additional level of indentation in the
code.

So I'm wondering if there is any chance that sparse will be able to handle
guard in the same manner as scoped_guard?

The code I maintain currently has no sparse issues, so if this cannot be fixed
then I'll have to decide whether to use scoped_guard (and indent the body of
those functions) or just keep the traditional "goto cleanup" code.

/jeff
