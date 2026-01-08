Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D363BBA14
	for <linux-sparse@vger.kernel.org>; Thu,  8 Jan 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865124; cv=none; b=bGpdBYqaBXRaZxe8clYzyQR0IhTgF6GwkNqWHZ8I80rYHW9ZTS2Iav8Qct+rbJsbFhVaVsA1d0dZdrTWw4zHVyhs+MMI+x+lN1pvOCZx5wcOaPT1bf5KHv3cdoNRDrccfiUbFl1bk5ZftShG1aozwfWEQXHnz/N8MdMMtJSDPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865124; c=relaxed/simple;
	bh=BuQYe089HDWu6lVFjQ9bI5Yfn6LuYXkzyLeIhE+R23o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+NsVJk7abiDQaxNI0E6n1gDKJU/5xhuCwdEfUYTdj02HaJa/31gPcPw85KVPPYzXHCtOYV8BaJYlXQvspoumfNSDyhuQsZ0DJxu99FHfMpn9/Jn0djRBCKDHNbG4oIkaoZ8aM1LgBojtlt3FrXhJp8NzQvoWSW++GqOlWvKiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=rSBQFNqj; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="rSBQFNqj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=L41T5mTCI2k4//h3ALXPwwgF53kW9rqiME0VNRDt5Ig=; b=rSBQFNqjtdTs/pUy
	uis/FwZQQorLY/ixdZi0np9yssvPGiLNQ/4x42JewZS2qzkqzZtEvWIixq/khdLZnFwkzRl9YtfYK
	aJcWpqzA3tjkK+nV2FWXJcPExg+tP3aCkeo6hHCeJHBKKrePJIBlzPmMZP5b/Ip29WMX7EFBOEcjK
	ewgGt1m6biF8WMVu9ax0C7blRiSS0VWzyjw/RDaHAfiv8cGvNWLeDQa1AuWxf8/cy9HnMeVS4/0o1
	Zvdv5DFX+DjIls35vEv3SsM+0/11Ed/Okx+I2JbTN5ePNZLv4trxVGJPDrLl+NsXWZxHGSNBoYQE4
	gMAZfabGlLFLPq6Vsg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdmTN-00AS5O-3J; Thu, 08 Jan 2026 09:38:29 +0000
Message-ID: <13cb6e5b-94f0-487d-a8fb-9e5ab8a3e45c@codethink.co.uk>
Date: Thu, 8 Jan 2026 09:38:25 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issue with _Static_assert and __builtin()s
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sparse@vger.kernel.org
References: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>
 <aV9DhtIM7Z5ZmJRz@stanley.mountain>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <aV9DhtIM7Z5ZmJRz@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 08/01/2026 05:41, Dan Carpenter wrote:
> On Wed, Jan 07, 2026 at 07:41:45PM +0000, Ben Dooks wrote:
>> So I am looking at why the Linux kernel's check for nul characters
>> in strings is causing errors out of sparse.
>>
>> EG:
>> drivers/md/dm.c:3813:1: error: bad constant expression
>> drivers/md/dm.c:3814:1: error: bad constant expression
>> drivers/md/dm.c:3816:1: error: bad constant expression
>> drivers/md/dm.c:3817:1: error: bad constant expression
>>
>> I've tracked it down to the sizeof(str) - 1 == __builtin_strlen(str)
>> failing to be a good constant expression...
>>
>> This is an example of the assert which isn't working:
>>
>> _Static_assert(sizeof("moo") - 1 == __builtin_strlen("moo"), "nul!");
>>
>> This does at least get past w/o warnings
>> _Static_assert(__builtin_types_compatible_p(int, int), "doh!");
>>
>> I've had a go at updating builtin.c to deal with __builtin_strlen()
>> for a string constant (attached) but that's just changing the
>> output to "error: bad integer constant expression" so not sure
>> what I've missed here.
>>
> 
> Al has a fix for that.
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992

Ah thanks, that'll save me a few hours of prodding my code to try
getting it working.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
