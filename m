Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A0175BF;
	Tue, 18 Feb 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885830; cv=none; b=O8DLgUwetoZtaAcgjpG1O0GyenVM+NxdFNK1jgbn7qPlHCUSftTeCE+T3iUqEvc2GrJ5PJn+gzVtgfMess36Qf93Q726XnIAvCgkQ1Gk/eZCNcqc7pneOHa5swlOwpGH+fiKQQ+ShrEBxVcXcEIcwwo+KT9HQDYLRUelTxeyol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885830; c=relaxed/simple;
	bh=eEHGfn31I8CnhhzVB7iBU6gchtyan8J3HLDDVcsgx2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz2SiQQ5bhCcb7g7Uvi7pZqqG1JUQXr0QZTJXYpiqwQQuGmkLIF7WaDEYCZS6ZghOP2hoXzY6kjTQWaJopA8IfA+D7XjRIZY5DWy84dI5COZe6KXCH4wpUeG29Fn6eeizAgoRGn7kp5GYEMFSBRNGihokwIWM/NLLHXBPXnjR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaDeKty/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaDeKty/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2212a930001so54933185ad.0;
        Tue, 18 Feb 2025 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739885828; x=1740490628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jdDVOKHqYOsG0zTYeRIb762+LRWCt+s5e6AAnN87iM=;
        b=SaDeKty/hqqfeQjXibaiMm2GieF5+0FE9XEZ1Vd8G3eKM4RnB6HWuiLgkLpGaesgre
         AJOlHPPeDAGJ1AfbrlAT37EoL0KgPpT9xNcu4oOgRJd32tGY4JFO5OSDUkvnXznPm9ZR
         o3Wkf5Oapa92BpZTgZDvZg9DB/mFnIzzL/x8zVt0T/3b5jGM0mpb7aD6qOpBlb2mTvhG
         TdM4F+pkmHKeVdh4EHofAHwYc07DRQ+16hVICTGyFEAIMEzKOTGRTpWVKzxhUiY36iXT
         fDYBwkDGTKJUcy1GighuZUEHb02vDT5O+uVo4cEjRg8JD0EaCNnIqQ91ZZDR02J68+hZ
         uiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885828; x=1740490628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jdDVOKHqYOsG0zTYeRIb762+LRWCt+s5e6AAnN87iM=;
        b=wBS7WvTG368OQc++NH60zsn9BuFHUfuXRQU6wFzoB4Hf+5GgGmPoHCXlMPHOw8vuIc
         WP91TUgZHZ72O1k9TvX8XGXvBKZsS0FHaZ51a+Kru76e8ueMYiA1kvmb2dnwTedtKhYs
         t7tCafQFEjTVrm2Z5jVERDb4fzmucfYzPCtbzbsPmq7pdwgRwU3IXkCdBt6fL+rJgg2W
         DVBrhjvxsAr2SiYrjYCRgQ1Rp3wMlNqc4EpIImNbBBiBwLWxYLVde6+vPRQEo8cGTsIS
         3Xac7s2PruW6hOEuYITuvN3QyHcTOw0XbMdGCQlj0kuev+s51U3a4eL2MEnwp/rHJ/8y
         TXAg==
X-Forwarded-Encrypted: i=1; AJvYcCULi4lZsPdKgBNQwjFhpoShn1ehNVithpFa66pxEQqHXZAlNfYODFo2b7UPXHd8EHs6mSz+9jqL@vger.kernel.org, AJvYcCW8uT0sHyjxjt8lJPb7PRrg5a5IApKwrm0K+6DZqSgqBCt4dtVCRwRmJDNBqpCGm6llFrpQxkBa8kxN3aY=@vger.kernel.org, AJvYcCWAuQcCWWa2Blk61NDwVSI02sysnqZbe5oRmN2n2M2ipjoz6wqSAa4wDt6vTvopDEvDTFxMwDV/PHNk9wJn@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKNi8BgNuq+ELKPptpVpCb/BioBt4Tq/4usV0lbRtlhyiJeya
	9Ntp1rU6bjq7emteNumRXyNdTR8DSI5NinQapJvexx1769dn8Juo
X-Gm-Gg: ASbGnctmL9mqYZQJyx8wv0E7DbZzrm/Pc6EpTBdSnSdcbjRMkFEx3YEUwpASb5th+CE
	XJN0dMDqyCob7UZH8pNG1/nQ0tttg9a9bg2AD11N44xWFnomnT2OJbvVwA06dBu9ifK/+oyqNmh
	ZZ2K2FFJlCGXtW1ihmyfQ05s2idBd/2duanv7dsU6i/4Rujqxy0PKSQHGy869a+zlh/T44W71RA
	biFBDQHsuRSc1uLO6yL3vessvBO/vL3c/QO4VL//vQSrPvsnxVqDK0I6D9n3PD5EHZfbhiga7q1
	ltv6FSgdBswojEciT9Qa1p+yCpTM8a10WEytqSgDVZk4iHUgcKjONBATN3ntVggrz6DD
X-Google-Smtp-Source: AGHT+IFAYv6dxLs8ydLkGWmiyk2TMBMKqMexuJxecoTUNnPqX7xuJaDjkSEiNhPja+6i+N766Hr0jg==
X-Received: by 2002:a05:6a20:e30b:b0:1ee:7fa1:9160 with SMTP id adf61e73a8af0-1ee8cb0c9e5mr25573150637.6.1739885827908;
        Tue, 18 Feb 2025 05:37:07 -0800 (PST)
Received: from ?IPV6:2409:4040:eb3:5fa4:b097:c3d6:9ee9:156c? ([2409:4040:eb3:5fa4:b097:c3d6:9ee9:156c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade80053bf9sm4374585a12.29.2025.02.18.05.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:37:07 -0800 (PST)
Message-ID: <0dcf0f9d-6ced-4fdd-9dc0-083ff161354f@gmail.com>
Date: Tue, 18 Feb 2025 19:07:01 +0530
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
To: Simon Horman <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, skhan@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, linux-sparse@vger.kernel.org
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250215172440.GS1615191@kernel.org>
 <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>
 <20250217111515.GI1615191@kernel.org>
 <bbf51850-814a-4a30-8165-625d88f221a5@stanley.mountain>
 <20250218132123.GT1615191@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250218132123.GT1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/25 18:51, Simon Horman wrote:
> On Mon, Feb 17, 2025 at 05:14:14PM +0300, Dan Carpenter wrote:
>> On Mon, Feb 17, 2025 at 11:15:15AM +0000, Simon Horman wrote:
>>> So, hypothetically, Smatch could be enhanced and there wouldn't be any
>>> locking warnings with this patch applied?
>>
>> Heh.  No.  What I meant to say was that none of this has anything to do
>> with Smatch.  This is all Sparse stuff.  But also I see now that my email
>> was wrong...
>>
>> What happened is that we changed unix_sk() and that meant Sparse couldn't
>> parse the annotations and prints "error: undefined identifier 'other'".
>> The error disables Sparse checking for the file.
>>
>> When we fix the error then the checking is enabled again.  The v1 patch
>> which changes the annotation is better than the v2 patch because then
>> it's 9 warnings vs 11 warnings.
>>
>> The warnings are all false positives.  All old warnings are false
>> positives.  And again, these are all Sparse warnings, not Smatch.  Smatch
>> doesn't care about annotations.  Smatch has different bugs completely.
>> ;)
> 
> Thanks for clarifying :)
> 
> Based on the above I'd advocate accepting the code changes in v2 [*].
> And live with the warnings.
> 
> Which I think is to say that Iwashima-san was right all along.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [*] Purva, please post a v3 that updates the commit message as per
>      Jakub's request elsewhere in this thread:
>      https://lore.kernel.org/all/20250212104845.2396abcf@kernel.org/
> 

Thanks for the review and clarification! I'll prepare v3 with no 
trailing double spaces and a more detailed description.

Best regards,
Purva
