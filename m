Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA41D6DBB;
	Wed,  9 Apr 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202185; cv=none; b=cPLLfvnDrArG9MPpK7wrGWg6flQje54G2WjooQdeyA5USjpWdOZsVtKMTF6FpoyvSB6q2N8xevtfiGYGN4qicr6vBhuCDSrCxnGuO/1G1CCvwlc7EjWvFtRnreP1QcxzciEkaOkFGWpNfpY3YFMurifztlUQLhFA8VRCgpUfcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202185; c=relaxed/simple;
	bh=reNrLo3+DjFKUwSurrxm1pFdzTIv4p0RHQShaGPr4/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B596EHJJGxRlhAPuBEWSxYH/vnE3qrqD5jbxKXoHQk4drPHEYcE5qfgC1GieuJpQZ/eAl07qP23y8jntMksP472Yw70mYxjYyZxUHuZUxO7QbKSCmdRBwX81nYje0JnAb3Pw3HctAHqqfKUV6AAFIkHNhD7hycKIkO9tcEkmORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JD/Yt3u4; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JD/Yt3u4"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 2UVtuD2dfbbeQ2UVxu0ZAC; Wed, 09 Apr 2025 14:26:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744201608;
	bh=ZRWbnuePKomXRAI4rd8dmek5QXJLiSrG2ToWqnrptD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JD/Yt3u4YXicmsBjsqhT9srtw3N+5PQDT8jexgNO9dQU66MUlMNVrRREFn9TSZIuh
	 Ig7CVdeb57vyZOX2HrDy/Dr6hV3h+P9G84DZevnDD4kH87L7H7aALHgpULt7JUDbgo
	 y65Ff6I9QTuPRntGwDq6tYaqyRDxIKnmZGNC4LKTccOKuAND3+ClfK/PNiAUAKcye2
	 od7TAyNfVwskI0oSv23BHZuYrPaMzxm/KLIJBCXVWUGgazOKVv5Ea68dXJdZYLgfwA
	 DbcoX2Dps5EOTFkdmJEGVPbT6BDRJGYx+WTUkZBMcnCLCm2KfDficpHNx2UazplPlU
	 vDguu9e/0OGLQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 09 Apr 2025 14:26:48 +0200
X-ME-IP: 124.33.176.97
Message-ID: <4c01c2a6-5271-41e4-8013-836e59aeae6d@wanadoo.fr>
Date: Wed, 9 Apr 2025 21:26:41 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
To: Kees Cook <kees@kernel.org>, Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
 <202504070945.BAC93C0@keescook>
 <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>
 <202504081202.7CA5DBE@keescook>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <202504081202.7CA5DBE@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+To: Yury Norov

On 09/04/2025 at 04:03, Kees Cook wrote:
> On Tue, Apr 08, 2025 at 10:23:53PM +0900, Vincent Mailhol wrote:
>> On 08/04/2025 at 01:46, Kees Cook wrote:
>>> On Sat, Mar 29, 2025 at 01:48:50AM +0900, Vincent Mailhol wrote:
>>>> __BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
>>>> do a static assertions in expressions. The direct benefit is to
>>>> provide a meaningful error message instead of the cryptic negative
>>>> bitfield size error message currently returned by BUILD_BUG_ON_ZERO():
>>>>
>>>>   ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
>>>>      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>>>>         |                                                   ^
>>>>
>>>> Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
>>>> __BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
>>>> _Static_assert().
>>>>
>>>> Use some macro magic, similarly to static_assert(), to either use an
>>>> optional error message provided by the user or, when omitted, to
>>>> produce a default error message by stringifying the tested
>>>> expression. With this, for example:
>>>>
>>>>   BUILD_BUG_ON_ZERO(1 > 0)
>>>>
>>>> would now throw:
>>>>
>>>>   ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"
>>>
>>> This is so much easier to read! Thanks for this. :)
>>>
>>> If no one else snags it, I can take this via the hardening tree for
>>> -next once -rc2 is released.
>>
>> I discussed about this with Andrew by DM.
>>
>> Andrew can pick it up but for the next-next release. That is to say,
>> wait for [1] to be merged in v6.16 and then take it to target the v6.17
>> merge windows.
>>
>> If you can take it in your hardening-next tree and have it merged in
>> v6.16, then this is convenient for me.
>>
>> Just make sure that you send it to Linus after Yury's bitmap-for-next
>> get merged: https://github.com/norov/linux/commits/bitmap-for-next/
> 
> Could this land via Yury's tree?

Hi Yury,

I have this patch:

https://lore.kernel.org/all/20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr/

which depends on commit b88937277df ("drm/i915: Convert REG_GENMASK*()
to fixed-width GENMASK_U*()") in your bitmap-for-next tree.

I discussed this with Andrew (by DM) and Kees. Because of the
dependency, it would be convenient if this patch went through your tree.

What do you think?


Yours sincerely,
Vincent Mailhol

