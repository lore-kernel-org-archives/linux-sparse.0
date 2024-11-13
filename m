Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7942022E2;
	Wed, 13 Nov 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520074; cv=none; b=CN7pc54rCkY70qn0e4TM0iN5BjwvJ9oiwbpD2St4t8P/JXpvTq7Y0wvXUJYpDxS7TJoVEgs+JrV64oeHh3/Yij2X1ex7Cnr4mnhbkQjrFgH2FnYyXUgzIy7hDDugvHiGvl9cSJ0qTDfM/fE002efMFfDCMtZx6+7V32rjDwe0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520074; c=relaxed/simple;
	bh=BENcIZAB2L/VXtw1cTjcAUJVB1fmyn2KqGDpT5/UDFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyEupBm+hxP8zh0gwu+MZ+aTtVY8IF8rvvVMJfMiK5EhB5drOjVMpRobB575aCCaGCTxfO3NM8ZhJ3KTLhR9I3CFhUDsxT9X4tpj4hm7CpRzWBUE/yQHh3WKBFSSWWDYO1Di/mawpjUJekWnQ0FY4S+b8m3KwszyDKZx5bTlftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KOcSLkVP; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KOcSLkVP"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BHSttiiouzWgFBHSvtiswK; Wed, 13 Nov 2024 18:47:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731520064;
	bh=E2mvNshzIFwcAQdVHJFlh5tqfY/CGH5s1fMXjHb6vQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KOcSLkVPmPD4m/1HGnJFM8Iu98QrEqHXkT6hh55/I2yHqYKYVCLYh8khRbsJkCdqt
	 JQ7qwDwv30hMtOFIrJQzK6B63lPSIFS9C8HVEY5DlEalC4vzSPzB0tcRHExbBu9Mct
	 3l8hixxVzUtwtc8Rvlh9aql+XCRqg4DJ6Kzhe8xGSDNUzh0zJOPQcK7KECjfcgaeMP
	 L7umdJR9cORdmy7oMppcXzKluySP6CqYzMNdngOd0XcYGMcGp3AUlwuedIqrF5eFsO
	 CAXV+lyZ0+2yfwkyDMf2h6Aal10OR+nEggcwHJ9q5WPAeAySNqirB4QASDwtKqdX1E
	 MzUfIeqvw7kqQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Nov 2024 18:47:44 +0100
X-ME-IP: 124.33.176.97
Message-ID: <46e494ba-a1c5-4576-adbb-b63c77a73365@wanadoo.fr>
Date: Thu, 14 Nov 2024 02:47:38 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/2] compiler.h: add _static_assert()
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
 <20241112190840.601378-5-mailhol.vincent@wanadoo.fr>
 <8734jwnrrz.fsf@prevas.dk>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <8734jwnrrz.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 at 05:03, Rasmus Villemoes wrote:
> On Wed, Nov 13 2024, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>
>> Declare a new _statically_true() macro which, by making use of the
>> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
>> constant expression.
> Looks sane, but $subject needs s/_static_assert/_statically_true/. And
> to be completely pedantic, macros are defined, not declared.
Sorry for the silly mistake in the subject. And agreed that "define" is 
more appropriate than "declare" when speaking of macros.
>>    - above examples, and a bit more:
>>
>>        https://godbolt.org/z/zzqM1ajPj
>>
>>    - a proof that statically_true() does better constant folding than _statically_true()
>>
>>        https://godbolt.org/z/vK6KK4hMG
> At least the second of these might be good to refer to in the commit
> message itself.

Ack. I rewrote the set of examples in the v4 and added a few samples to 
the macro comment.

Yours sincerely,
Vincent Mailhol

