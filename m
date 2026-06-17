Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B772D0614
	for <linux-sparse@vger.kernel.org>; Wed, 17 Jun 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705791; cv=none; b=WJMxDDz5xymuxu0WcqSYQwdXo9vfd053afH3P7YXP9qPqOLUPP7PwDo/sbmPtIzmu9YmO5YSHwJzR3vRRFX6pXmXTAPs/5T5Pxz4X8/c64Yej+UgwV2irRqSPNqYg8WwLj25DtmRCB0GZ7qLcu+7vqLGQFVVUee4AQxUaUGkB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705791; c=relaxed/simple;
	bh=AYtIjdaB9/iHAq10TbWZLR7DDH3dCiMvVeEBSdmaAAI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IRFCiher6dCamAkqmS0J3Fe7fR9tMVTurB8plOqWiaABUZwAgYnPt2IshmmWQ6b5qPTc9fmmdLS1zw3RG0Cr/YI7Wb2Oq8yd4l4pt+btZT52xJZF9W2bUTUq+igfZ9fi+IPUABk1rwHnKdxfvR7C7S5rrz5stNHbDoxrqeFMDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=r8/1w3E7; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="r8/1w3E7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc; bh=p992pd3plNSqd/piNxbRrwBNHL2A0sThobvPNtcXlAE=; b=r8/1w3E7Ud8dgPWh26PWEf
	PnAhqPWy3Hw4mpkDV/9pXOEXKSXMiOQiqeQjSqQeD3ITMGsa5GTGqdoAKc7+Fr2yQidlhBz0v4Lfd
	nyT81Q49A+rR32diDppPHKVhghawGEavfCd9+LnPf+TlyUvFpTz5mwObVoAP+6Vcs4cEXoara0FM7
	H4YFopT5j2N2DNXNTmaQX/HNg0vbVteaLPpaS7qhko6d0vJ9w8+VG70gSnWTWRiNbrUNvZFbAoMTh
	/yoGUu9n55XQUN38dusgWAGHOw2zaGr3f8jI6LZU45ZNYDVIXckKUdlkVFQiPSFAG8qFaMdaLlbpY
	04hVENLKj7Xw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZr47-00DdJS-KY
	for <linux-sparse@vger.kernel.org> ; Wed, 17 Jun 2026 15:16:27 +0100
Message-ID: <0e0a2543-bac9-41d3-9c06-1579395a1de4@codethink.co.uk>
Date: Wed, 17 Jun 2026 15:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: segfault with latest arm64 linux kernel build
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
References: <ebcf4663-4c95-4b51-887c-d0c99b8b80ea@codethink.co.uk>
Content-Language: en-GB
Organization: Codethink Limited.
In-Reply-To: <ebcf4663-4c95-4b51-887c-d0c99b8b80ea@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 17/06/2026 14:58, Ben Dooks wrote:
> I'm getting a fault running the sparse check on current kernel.
> 
>    CC [M]  drivers/gpu/drm/msm/msm_gem.o
>    CHECK   /home/ben/linux/drivers/gpu/drm/msm/msm_gem.c
> Segmentation fault
> 
> The base of my tree is, however I have a pile of fixes
> on this:
> 
> commit 4b99990cdf9560e8a071640baf19f312e6ae02f4 (origin/master, origin/ 
> HEAD)
> Merge: 9c87e61e3c57 52d4ab1ca790
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jun 17 10:21:00 2026 +0100
> 
>      Merge tag 'drm-next-2026-06-17' of https://gitlab.freedesktop.org/ 
> drm/kernel

I did get a coredump, and the error is at:

> 0  simplify_cgoto (insn=0x7f5fb0ab5240) at simplify.c:2737
> 2737                    if (!target->ep)
> (gdb) 
> (gdb) backtrace
> #0  simplify_cgoto (insn=0x7f5fb0ab5240) at simplify.c:2737
> #1  simplify_instruction (insn=0x7f5fb0ab5240) at simplify.c:2850
> #2  0x0000563adaef4e30 in clean_up_insns (ep=0x7f5fb0b48198) at optimize.c:42
> #3  optimize (ep=ep@entry=0x7f5fb0b48198) at optimize.c:98
> #4  0x0000563adaef49ae in linearize_fn (sym=0x2, base_type=<optimized out>) at linearize.c:2577
> #5  linearize_symbol (sym=sym@entry=0x7f5fa9cc1b30) at linearize.c:2593
> #6  0x0000563adaee7c2a in check_symbols (list=<optimized out>) at sparse.c:306
> #7  0x0000563adaee779d in main (argc=<optimized out>, argv=<optimized out>) at sparse.c:332


Not had time to go look into this further

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
