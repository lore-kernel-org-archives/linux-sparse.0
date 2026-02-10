Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABA366560
	for <linux-sparse@vger.kernel.org>; Tue, 10 Feb 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734452; cv=none; b=hILuuy9WgYtTmwIqPXo3dJKycGSBYi0kn9GFng7G7KZW6ZR930X/rwZE6izBS28ULE0TunuMVDExxaElBI++JhsaEp7IygBNgdLQFfDfx9F5SLZoHF0moxSevymc26iMc5iwtiN1P2335BVmyhK1masJrC+VfTwe2AJwPwsNkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734452; c=relaxed/simple;
	bh=XjkKjpfB1T4JjwrLohx5sCAipRWg8MDqoemr/e2UGXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIt9HVCReId5sebGlfsHuocCMUA8G26paSsYbWjIhWpPUlk1d8BJkna2TsuRzdySXZVnxJfk3IBafZtflN7uoiSNOJPi30ms/9hztPNrkc1iR0B047vTQDDb2w6+p6vJiyGK1Or3yewuXPGrNhQ11TuAcsHp2PIGHzpI6RJoNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0hjc57l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CwtEuJ6R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0hjc57l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwtEuJ6R"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AEAmvW857095
	for <linux-sparse@vger.kernel.org>; Tue, 10 Feb 2026 14:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XjkKjpfB1T4JjwrLohx5sCAipRWg8MDqoemr/e2UGXQ=; b=a0hjc57lU0t0vj9x
	sCf0Q0JBSyx3RNw3zGx2JMgY+BtyBqjDZ5fAeRWrHUrCvNxrToO+YZT0x1eTkl0m
	HYcwweEFttSeyFB/WwgKoHv5Ck7yfQByEV4XYnTu0hgqezKAjQnECMXSqhfW1kWq
	KPwTXgkwBIh8Xqi2Si7NkbSBPgJVljl8+I1YlJqfrtVvF87LOrCN0OeoUz7iSVa8
	D2k4kkphqO8wgJ6BFdqKhh5s3jsqoRFXyPDp8Z6CsMGi3DCTa4UCUwkwMJ/m7ECW
	Nh4fJDwnYW9QeBSERw0ciP/yWh3SilrSxAnDEQZvR658bW6Orj7vEAKImHCJn49m
	/FVI8Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga64jam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sparse@vger.kernel.org>; Tue, 10 Feb 2026 14:40:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124a95d580cso40639209c88.1
        for <linux-sparse@vger.kernel.org>; Tue, 10 Feb 2026 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770734450; x=1771339250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjkKjpfB1T4JjwrLohx5sCAipRWg8MDqoemr/e2UGXQ=;
        b=CwtEuJ6RDIH2qdooZX5lDy/+W5+WT4Hh+MiuDwIyObfC2hUs1e73T4yuN4HuK4WK9H
         Eo0eaodq8e1vQUIotjdyHj5pPiTokhQsVpJr53MSoFCxy7bp9nvlbc/gtOh3Dvf+0uV6
         iqO8B7noN/k+3Uw2MtcM5rOxJZEfBPSspKpi5a01PmuN0mHkd9eyc6djaJQeDkD95slW
         DCOWqWHbHKNT3xYQGiqVev7n+xwbwl3gmk+Ouzh8KEIxJjDqYLq+jEhv9I0NrLzRyTiL
         39DXpCCiOgo4EOgh+J2jQSTMeMxg+JUgmqObuuM9AOJrWPeOFM6L2p4LcBJjjK08YNYC
         dpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734450; x=1771339250;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjkKjpfB1T4JjwrLohx5sCAipRWg8MDqoemr/e2UGXQ=;
        b=K9GR/Ucs11CIOK52suiyw5vY4dpfYEk55OXIZzSNaNf/vuPG2dcdjdkgF3YY3Df9Qs
         gcloQ+B5ouye79f7Etl8ablThyvSMxaKw6htoNGMQmzD3LS9junqYuW9SCDINMdt9Sob
         sUELyIaJnXkJz3gGI+08ieiGWbLamCada7jkuAFSfJBrjOa0tVCe0/qcZ7gQqai7EdXI
         gSDpljdDHyCyuQHgh+fSaUGQdTU+g47NPgIixnvoqr9VBmpfFeqdGKaEOG/yLvt7zLAg
         C13gxlZGyzQRrJa/mFdaqZZ9V0qWXGInezcdC2KLpNMzhSpAfJ79w+beqIOTSkJgkaNs
         rRTA==
X-Gm-Message-State: AOJu0YwEWwhW5mxtj6F4hgos7MUPSNAtl2KNMGKtsXK54DzXTNCHYQmP
	MscEcJ1t/D/4UCANPdK1fviBGP6iUvHASlwzy3dpNBJTholsYP87hBpGtJCQQCgEshzI08RpfE4
	42dCHqMKBbj5yFX9nH/CC3zh7NGQSObj0a9rcr05x2ZLAVT/kkV8LGDBnYxUGQYyCgJ8=
X-Gm-Gg: AZuq6aKgx8YiDTB2bYEX4rRggQ33fnQcgXJm4fY0Nr640TMbnhfToUAkZTjL56bobzz
	RnsmIqOCQJLfqgIUFNsrVfbuGvhiJGjnsWHPKG1rWVZK0yJL9hDyymFb8loSHz056QF/k+Sp/Xe
	aeQVADYb41hit/1QeNo85ZbGfDTcBznJ8SwNK54UFuJO6cdj47Y0MadBATpmY0uTmiEpb5dD2d2
	f4FVFYUHp6tQ44TQUv4TzHNBQHuFQgTmz0u+NGGyUsdM/qYx5brgl24HhadlAbKjzNHU7TvuNLm
	6p1dBC9S4x/2CZVczwOSqTR/2OC8Q6fmk0+23SAFRf5t+xgEvGixs82R5Y4gPrfSgBroPh4nVbi
	MjADuqnQZ+06c1bmp9/PUUxGUdtpftw6lIteq5yEkXkGtvmQgUQyiLmst5IQGVUz9u06rNqhM7v
	99wQW8pA==
X-Received: by 2002:a05:7022:618f:b0:125:be41:db5b with SMTP id a92af1059eb24-12704192801mr7210993c88.42.1770734449909;
        Tue, 10 Feb 2026 06:40:49 -0800 (PST)
X-Received: by 2002:a05:7022:618f:b0:125:be41:db5b with SMTP id a92af1059eb24-12704192801mr7210981c88.42.1770734449319;
        Tue, 10 Feb 2026 06:40:49 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm13253430c88.8.2026.02.10.06.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 06:40:48 -0800 (PST)
Message-ID: <4121dfdc-a1b4-49da-83e5-1042950dea6d@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 06:40:47 -0800
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issue with _Static_assert and __builtin()s
To: Ben Dooks <ben.dooks@codethink.co.uk>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org
References: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>
 <aV9DhtIM7Z5ZmJRz@stanley.mountain>
 <c57d33cc-dab1-4846-9c51-c358710a01c9@oss.qualcomm.com>
 <1b4aab7e-28ad-4b8f-a2f4-fac639e923bb@codethink.co.uk>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1b4aab7e-28ad-4b8f-a2f4-fac639e923bb@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: do4DObHXqOqTqdkDbrcUX7Fq0VIeUdCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyNCBTYWx0ZWRfX8P3DUN9Nfppl
 3OTzhQGfpRFTEEdcHEP89z+9Bzt8CVuA0xNaYFWCHP2AhY80J2EACeS89J69uiC9kO89FjxKpJm
 JpNcu1OWzWjncdZPQIY5xovDrbPuqfHv351z5vudlPGyfODotvb8S8FjEHHLNPCFhpems/SXvPp
 aGlZW4+Mpc9BUXA9dyWHWwieD7qsfiSYI9fanKSHBJqsGXXHYpWETBnmVFqZJXc/J70+i1cGoC8
 Y884Xnxj2IFrs8eevY7hsaZTNLYc0yQM9souDirhGdmaGIW/ztKOEmKtMpbGbgEnU0spHFt85n1
 BBxAtnzKAQ3Nk8ntxBHG+PuSL6DspFItrzuhIK5EJwfo4yC+sL76NW+x9I2jmyFRLlpe25O757M
 pdGj5I2KPR2G594Rnk9qQJ0iX54cINMQqWOYvucI2MliF10KsN/Y2fj9x96SlsQorY1wXWDuPbi
 X3bBgD1fmVOiC1f5r+w==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698b4372 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=LKH9kFaUQpisumV5IV8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: do4DObHXqOqTqdkDbrcUX7Fq0VIeUdCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100124

On 2/10/2026 6:25 AM, Ben Dooks wrote:
> On 09/02/2026 16:25, Jeff Johnson wrote:
>> Al: Will you be contributing this fix (and perhaps the rest of your
>> accumulated changes) to linux-sparse?
> And are there any other goodies in that tree?

There are...
https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/log/
