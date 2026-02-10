Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49828DC4
	for <linux-sparse@vger.kernel.org>; Tue, 10 Feb 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735682; cv=none; b=fH5qufosPPDEpCZuQ1EfKKzwXrjfNHdTSbjGA03nyDXg/MZIzbEQsjvSupP3w3luF+VLB8FvpoM9aXycExWbaJJ8fQwOUzVmfh4/eTsgosj2pYVPx4mH577RWPw+gy+YcY/ar6LO9R6yMGVOMmrDfRDzryk05NxlEu+trGwwmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735682; c=relaxed/simple;
	bh=FGrh1lPHzti8EIsZSmtpGmZJ/7g9Rbf1ofrOwrDSSb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbZh6kPm32/kiV3g6xc1HHoTm0pzGp+4nnVnn960Kag1lAjYBlxZxaeHgx9BDIkJWhkRwOTDhYyDmZbqaPLjDA7suFldYiWp2UnMgZmrvBf+hsEnM3M3Z02o8Pu7ZBEJAQ9jLR7lop/mkknOOp0E5InpyRkidl6pQQJ91eBXgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=H+GSq1i3; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="H+GSq1i3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=MYJofJvvy0TzAh5niKkN75Gpmlp8hJziSwnCJ+ip8LU=; b=H+GSq1i3YFn0NbnQ
	DzYKJq0sUZb4KArH2kURZZYAP4uNCtvs5+tabfxggkHZjHu9ox+sDTFhNDTUWcUQqMUUamdX0raWC
	jfm0Y05Nph9OdUe/vKtif/yDg5wmVaJnbYo8ExHi62uP28RU6SceLBVYQVJTBL/gSnnQHirjLxzfJ
	3rJmmN2kof8d1T3wukpwm7aLWUPWkKCvEG2dAUogDfRrbNEEsW6a3ujzk2kVgN94hxTUT9t0LH+86
	5q7Auf+pjfLyFxdXWChmscgFoY8RylknFRbbKfQ4GfMrBlyDy07syo/zZGKGXYb1NWiBsFJ73ch6E
	x6tD9/Tyu/wm2MOjqQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vpofy-00BSwa-Qb; Tue, 10 Feb 2026 14:25:14 +0000
Message-ID: <1b4aab7e-28ad-4b8f-a2f4-fac639e923bb@codethink.co.uk>
Date: Tue, 10 Feb 2026 14:25:14 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issue with _Static_assert and __builtin()s
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org
References: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>
 <aV9DhtIM7Z5ZmJRz@stanley.mountain>
 <c57d33cc-dab1-4846-9c51-c358710a01c9@oss.qualcomm.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <c57d33cc-dab1-4846-9c51-c358710a01c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 09/02/2026 16:25, Jeff Johnson wrote:
> On 1/7/26 21:41, Dan Carpenter wrote:
>> On Wed, Jan 07, 2026 at 07:41:45PM +0000, Ben Dooks wrote:
>>> So I am looking at why the Linux kernel's check for nul characters
>>> in strings is causing errors out of sparse.
>>>
>>> EG:
>>> drivers/md/dm.c:3813:1: error: bad constant expression
>>> drivers/md/dm.c:3814:1: error: bad constant expression
>>> drivers/md/dm.c:3816:1: error: bad constant expression
>>> drivers/md/dm.c:3817:1: error: bad constant expression
>>>
>>> I've tracked it down to the sizeof(str) - 1 == __builtin_strlen(str)
>>> failing to be a good constant expression...
>>>
>>> This is an example of the assert which isn't working:
>>>
>>> _Static_assert(sizeof("moo") - 1 == __builtin_strlen("moo"), "nul!");
>>>
>>> This does at least get past w/o warnings
>>> _Static_assert(__builtin_types_compatible_p(int, int), "doh!");
>>>
>>> I've had a go at updating builtin.c to deal with __builtin_strlen()
>>> for a string constant (attached) but that's just changing the
>>> output to "error: bad integer constant expression" so not sure
>>> what I've missed here.
>>>
>>
>> Al has a fix for that.
>> https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992
> 
> Al: Will you be contributing this fix (and perhaps the rest of your
> accumulated changes) to linux-sparse?
> 
> /jeff

And are there any other goodies in that tree?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
