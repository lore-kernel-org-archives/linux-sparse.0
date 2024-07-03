Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730217BB0D
	for <linux-sparse@vger.kernel.org>; Wed,  3 Jul 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018992; cv=none; b=LwJZfvS/vSamlYf8wiWPLFCHBD7UHdYbFamD4/VyABt6gWv6VrJUSm7ceP5V6K1T5QP32sGhnnXnzNvULIOy2pwboRjKiWHAepwJD2E8AlxCUgFvmpxUPsKe0vxysPPSEYbewLEe/uqMhFzP53gPVrrh7LHFSTNM1L5SQy9YrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018992; c=relaxed/simple;
	bh=UhrpJyAvb14kH+pZ/UOwLLW/dq7aE7JNqVMUSy/H8Ww=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=KAdXu21y6bpKrHIOyPuQVMvli/L4FwrGj2b3+OldAamjnEBM0yEb8wgLCb0O2OxGq9P1QeoWcsC6QSguWaLfx6VMtHKzihZsfQ/TsS77nQ1vSJWfS7IsTm2Q6oAmHmXdk7sucs5rfDVNVhmV66hF+WqyA0ulOANITmDtQPjrUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Rjdf8QhF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Rjdf8QhF"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4636JL3u030004;
	Wed, 3 Jul 2024 10:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=UhrpJyAvb14kH+pZ
	/UOwLLW/dq7aE7JNqVMUSy/H8Ww=; b=Rjdf8QhFtkZcvgrfbDeEJcGHlJ2B7Ptv
	aHnPiz4S7ZYp/vTQUNS479yilOKhyjWf2FX8j+NlG/fU8yM8Njsv88b5yqRJF45p
	p1gyNue2TuMqPdf90HvsmXVtD8/VKLi7ArBUi3j2Ssz7vn8rZAiYp/JTDuPbxrnU
	FIDPVGdcIosuFUK/NqcGrOX93phIhAGRVh7dAD+SDNMm8Lc1U8BmOjP9hyqstzUb
	M/aeILywdhGJ7w4KcQzzgiKY5Nf76Sl/J98eW33oceVwXqhp0e62wYKhnsVIiXEk
	n1SsYSBEy4+9oSICaZyCocrVUk1Cz413gYAq0Iu8E+RPD08NblWx8w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 402fnxd872-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:03:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 16:02:36 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 3 Jul 2024 16:02:35 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E6047820244;
	Wed,  3 Jul 2024 15:02:35 +0000 (UTC)
Message-ID: <65fee38d-8b16-43b9-b16e-3afdc899a2cf@opensource.cirrus.com>
Date: Wed, 3 Jul 2024 16:02:35 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: <dan.carpenter@oracle.com>, <679652+tititiou36@users.noreply.github.com>
CC: <linux-sparse@vger.kernel.org>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Spurious warning about using kzalloc instead of kmalloc
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gQhJl_FFJhr8pxzNm9PgofDHB88cq2ja
X-Proofpoint-ORIG-GUID: gQhJl_FFJhr8pxzNm9PgofDHB88cq2ja
X-Proofpoint-Spam-Reason: safe

As far as I can tell from the limited commit message and comments, the
purpose of commit 6a74b670 ("Refactor and add new functions tested by
check_kvmalloc_array_zero()") is to suggest that uses of __GFP_ZERO are
replaced by the appropriate zeroing allocator, like kzalloc.

But this warning is being reported on the function
cs_dsp_coeff_read_ctrl_raw() in drivers/firmware/cirrus/cs_dsp.c

That function does not have a __GFP_ZERO, the kmalloc is:

scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);

and it is intentional to use kmalloc because the entire buffer is
then overwritten, so it's inefficient to zero-fill it first.
