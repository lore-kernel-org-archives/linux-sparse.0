Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6C21CC64
	for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406408; cv=none; b=HcqjkWZv7O3dk6W7CvQWdoNM1EVrzHFt3STTYdb80L0aVSpE7jNQ6rPj96Ku8bLTDx3fTk8n34/NUjiFBcvc7J/lZl80Mm4j7gspmG92lwYORfxsjKf6F+5YYl+4p8M9j54aY5ywV9u/G9dqS5Hmkn0lMNAhkOVfdSC33E/uh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406408; c=relaxed/simple;
	bh=AhH4F75VNAYCHT8K2bW07qLDKtQZPRgfm70qY4NvFmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CammCXBdJuECdnwbzvL/lTMM1g/Idvx6C/ofmQ4KxOLf5kgpazaY+yvCiuXqyQ0+toSNwWa/k1FUJL8ikpKxV+ia4brTA7vgrLWODUoN73adYZuhmW+/Ncy+URurrzQgJIHOSi9bmi7qBe0zITWyeB+oZMRsO5l9WISWrPTFJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=O7wJESG5; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="O7wJESG5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=dYWf5CsjanJzcyf4+ydHwwhVmG/V1WGU5x+Ic4mKEC8=; b=O7wJESG5WWPaqXXm
	8enzKY+/Wwwufctiu/B7gQFfwJkrGjVSOJr9CL4TGLWNTH06VBxTW04muK1hlRcn+xPjTL9cargcL
	ApK8TjYT7fwTPVxxN+15kpZgJekHZVrQkyWHnNvhCv/UEgimZz8wQi/b50bJLaNKlR9UferyYlXdk
	Yh3BsOXwP2oPvNe1B6MEV9C11jpepkqAUozYtCXvA8pnMHrfjA01P4o/gopJOHcwSHLSYnkHxUbvB
	UuNgrinvFcLN69hA2nRl0buCZsRwbxLAPrnlp/sJWx4hFs/pF+d+Ndd8JQmN4VVqlbz6FJJasjFWV
	x0SzK/eyq7oa8LoLfw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vXePU-009q7z-UL; Mon, 22 Dec 2025 11:49:09 +0000
Message-ID: <11df30dc-e1d9-4f40-a9ac-43cb1af69da0@codethink.co.uk>
Date: Mon, 22 Dec 2025 11:49:08 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND2 1/4] parse: initial parsing of
 __attribute__((format))
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20251020153918.812235-1-ben.dooks@codethink.co.uk>
 <20251020153918.812235-2-ben.dooks@codethink.co.uk>
 <CACePvbVvsAPURh+jfb2Vh8cPsOzuR2HmzuD9j5Gf6GJyD2orng@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CACePvbVvsAPURh+jfb2Vh8cPsOzuR2HmzuD9j5Gf6GJyD2orng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 01/12/2025 19:23, Chris Li wrote:
> Hi Ben,
> 
> Thanks for the patch and sorry for the late reply.
> 
> Your format attribute series work applies to the sparse-dev tree fine
> and "make check" runs fine as well. Thank you so much.
> 
> I have some trivial coding style of feedback for you, see the comments
> below. Mostly just nitpicks, does not impact the coding behavior. Let
> me know if you want to update a new series or I can be lazy and just
> apply your current series.

Thank you. I've implemented most of your parse.c/symbol.h changes now.

I am not actually back at work until 2nd-Jan 2026 so may not get
all the other changes sorted.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
