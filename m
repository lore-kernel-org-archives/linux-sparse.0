Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF090217F27
	for <linux-sparse@vger.kernel.org>; Wed, 17 Jun 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706018; cv=none; b=DvkByTskW6IGYrNNIpI3zE9LWTes8kcNZcgpwiiz16VhNIf0pC+c87wINXVJNMR1hO0WKZwVHuUyHegri4Qy+XhfMvcfrofUh+0PX8bQgx95vXV4UayfjQeM/u4n+hAiyoRGdoGr/D2+bbHedt96lzwZtZFkI9m0l3+JAUk4CK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706018; c=relaxed/simple;
	bh=mvUMnNcXr7m++shrroC7fmciJHZIQ+jCKucQHN2NH+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Q5eNyZyzAOEHHx5Y5l/pgAYFr0f9a9JAQuJzW8rV58ELo2tXK05iMX4aw+gKw56Wfan8TmPEbAaCre/txhwja1c8B78Mw582WTMZNVfyVHHumDV4kCe1Lm8rJ7vv2MkmkVutrfURLoWlUzo28ZByd+5Pqgvwj7w9pclxs41n2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=pHZFJiEl; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="pHZFJiEl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc; bh=xdj/Y1Lb46XykZSoTL5PIaB3DxMhdd44BpUTDZbDNeE=; b=pHZFJiElZ+GpGoqx8BgXWc
	RSjQYh3pA+JzOTTKWI36HtWtVxHGD1/5dDEM8W7TL0GqSjysnjnacVaAu/0V/NTU+KOccVUo/w6S9
	qljGILWTss4kOJLE2ZPz0y1lYm5VZoQSDKNQcofypPp0f96YVeBR1uHxluRQaVGG9pEJSang90BNb
	aBqdT+6vQNdizbMmKsinCAdUqmZWH4X0aPisvz1w3CF6FxPxXP0fqhqQCBHpJG5jMzq/eKpp7+zNj
	Fo2XDee9JtV/GVR/sGSsAi3gPh0spOky/cZDOnaCvF3jjkvT7sitXbI/NnLzGfl5hlxiFxe73CSIq
	MvBgDSeHRZ+w==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZr7n-00DdyS-Fv
	for <linux-sparse@vger.kernel.org> ; Wed, 17 Jun 2026 15:20:15 +0100
Message-ID: <afe22c99-c4f8-4ade-92ee-c931b57df77e@codethink.co.uk>
Date: Wed, 17 Jun 2026 15:20:14 +0100
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
 <0e0a2543-bac9-41d3-9c06-1579395a1de4@codethink.co.uk>
Content-Language: en-GB
Organization: Codethink Limited.
In-Reply-To: <0e0a2543-bac9-41d3-9c06-1579395a1de4@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 17/06/2026 15:16, Ben Dooks wrote:
> On 17/06/2026 14:58, Ben Dooks wrote:
>> I'm getting a fault running the sparse check on current kernel.
>>
>>    CC [M]  drivers/gpu/drm/msm/msm_gem.o
>>    CHECK   /home/ben/linux/drivers/gpu/drm/msm/msm_gem.c
>> Segmentation fault
>>
>> The base of my tree is, however I have a pile of fixes
>> on this:
>>
>> commit 4b99990cdf9560e8a071640baf19f312e6ae02f4 (origin/master, 
>> origin/ HEAD)
>> Merge: 9c87e61e3c57 52d4ab1ca790
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Wed Jun 17 10:21:00 2026 +0100
>>
>>      Merge tag 'drm-next-2026-06-17' of https:// 
>> gitlab.freedesktop.org/ drm/kernel
> 
> I did get a coredump, and the error is at:
> 
>> 0  simplify_cgoto (insn=0x7f5fb0ab5240) at simplify.c:2737
>> 2737                    if (!target->ep)
>> (gdb) (gdb) backtrace
>> #0  simplify_cgoto (insn=0x7f5fb0ab5240) at simplify.c:2737
>> #1  simplify_instruction (insn=0x7f5fb0ab5240) at simplify.c:2850
>> #2  0x0000563adaef4e30 in clean_up_insns (ep=0x7f5fb0b48198) at 
>> optimize.c:42
>> #3  optimize (ep=ep@entry=0x7f5fb0b48198) at optimize.c:98
>> #4  0x0000563adaef49ae in linearize_fn (sym=0x2, base_type=<optimized 
>> out>) at linearize.c:2577
>> #5  linearize_symbol (sym=sym@entry=0x7f5fa9cc1b30) at linearize.c:2593
>> #6  0x0000563adaee7c2a in check_symbols (list=<optimized out>) at 
>> sparse.c:306
>> #7  0x0000563adaee779d in main (argc=<optimized out>, argv=<optimized 
>> out>) at sparse.c:332
> 
> 
> Not had time to go look into this further

my workaround/fix is:

diff --git a/simplify.c b/simplify.c
index 68c5f9c7..20f5cfc2 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2734,6 +2734,8 @@ static int simplify_cgoto(struct instruction *insn)
                 break;
         case OP_LABEL:
                 target = def->bb_true;
+               if (!target)
+                       return 0;
                 if (!target->ep)
                         return 0;
                 FOR_EACH_PTR(insn->multijmp_list, jmp) {



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
