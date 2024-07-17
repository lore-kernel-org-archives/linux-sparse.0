Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40A111A8
	for <linux-sparse@vger.kernel.org>; Wed, 17 Jul 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242094; cv=none; b=LvpWZ63SSxXRttDmS1XQaby6lcJ9dHKi6H0wlR/OKBd1C7uGzzO66BEn+uFE77gI1T9a0hVimB9Q/+FlzxpVCA6YSAPfGR+IspNXf8bOSppH0gnQuzNXQuGCcezBaxacyBc4LcrY5CqjsiAu6Lm+OETmsbKLtwAO0UCuCySXn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242094; c=relaxed/simple;
	bh=dRBcERQ8+WW7Ll8r04FUQVRukPAiUdMcegSadFk+Aas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XVE7oygyonpfFFXChWa2MchfwfHY+sMxj/AL6IMEIDZMAA8Vg99ShWJmiUGG1ZWluTvrd/sdXf8QF60REmijrkVejixEzvElUosbSc540h3/FqMYFVwYbFa9R6xu8AX0YdmxU8GH5oSDQaTpKmGlJMSO08CXjfM1tt9x3rkR4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=num9t0SA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="num9t0SA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3BFF187B4;
	Wed, 17 Jul 2024 14:44:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dRBcERQ8+WW7Ll8r04FUQVRukPAiUdMcegSadF
	k+Aas=; b=num9t0SAPBs50JfNNPrayD395vrmMSaL7Bb7nrC6aCOBXB9u4FMdPu
	AkuQhRwP4lKcFFedjBc+ZWMQTwUUP3Ng353WqeKCGQfSCPPuZ6M+Ci+EnW887xKW
	cKKOIipuZI6iqnVdHax66PwKylW32INf1Sdjq8NsdByZgxw9VtGfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB871187B3;
	Wed, 17 Jul 2024 14:44:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0ED01187B2;
	Wed, 17 Jul 2024 14:44:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <junio@pobox.com>
To: Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  Luc Van Oostenryck
 <luc.vanoostenryck@gmail.com>,  Sparse Mailing-list
 <linux-sparse@vger.kernel.org>
Subject: Re: sparse regex error
In-Reply-To: <uug4xslokvlxr6z24q52z4pt7nrtiimbzunz2gz3kpilk4kxts@7jljsksi6baq>
	(Luc Van Oostenryck's message of "Thu, 21 Dec 2023 00:13:38 +0100")
References: <6f853a6b-9ac3-4bfd-a968-89d43fbcce2a@ramsayjones.plus.com>
	<uug4xslokvlxr6z24q52z4pt7nrtiimbzunz2gz3kpilk4kxts@7jljsksi6baq>
Date: Wed, 17 Jul 2024 11:44:13 -0700
Message-ID: <xmqqzfqf270i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90F364CA-446C-11EF-9446-965B910A682E-77302942!pb-smtp2.pobox.com

Luc Van Oostenryck <lucvoo@kernel.org> writes:

>>   $ git diff
>>   diff --git a/validation/restrict-array.c b/validation/restrict-array.c
>>   index 04bfdad9..86753b7d 100644
>>   --- a/validation/restrict-array.c
>>   +++ b/validation/restrict-array.c
>>   @@ -29,9 +29,19 @@ typedef unsigned long int size_t;
>>    
>>    extern int regexec (const regex_t *__restrict __preg,
>>                       const char *__restrict __string, size_t __nmatch,
>>   -                   regmatch_t __pmatch[__restrict_arr],
>>   +                   regmatch_t __pmatch[__restrict_arr __nmatch],
>>                       int __eflags);
>
> ...    
>
>> which, similarly to git, shows errors not on the declaration of the
>> regexec() function, but on each call site (about a dozen in git):
>> 
>>   $ ./sparse validation/restrict-array.c
>>   validation/restrict-array.c:32:56: error: undefined identifier '__nmatch'
>>   validation/restrict-array.c:32:56: error: bad constant expression type
>
> Yes, it's because __nmatch should be in the function's prototype scope but
> Sparse hasn't such a thing.
>
> The following patch is a bit ugly but should solve the problem here above.
> It's hasn't had much testing, only the testsuite.

The same breakage came up recently on the Git mailing list.

  https://lore.kernel.org/git/xmqqikx42c42.fsf@gitster.g/

The patch seems to fix the problem when locally applyed to the tip
at v0.6.4-67-g3a4c5743 (of course we have to add -Wno-vla in our
Makefile when invoking sparse).

Any plan to polish it to "unugly" it and merge?

Thanks.


