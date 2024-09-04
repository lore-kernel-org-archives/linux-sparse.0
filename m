Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFA1474A9
	for <linux-sparse@vger.kernel.org>; Wed,  4 Sep 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443359; cv=none; b=Y8y7mxt2OD69fyFemR6FFWmE8PyHAq/yxj+LoLwJaVVmtUH+QdCj1rdFqOYnJ5rizmz2bJFSm/XbW86UEQSblZitx/jgwtoG3HgMJqi/u0h9h8UmLjjjZCSbbU1KOMrhf6Jo8jpRGtio64pucwgyPP+DX/DO2h2G5ypuPneLRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443359; c=relaxed/simple;
	bh=4UGpj5MYNoysU3Yw7iIE5j1/gh8Jy/erHDgnQ7067tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACo4D+q2l3arOzRmwSlkHIA8p7nBklcGeBezF1XTWU8gnZQkXYr1znlexbMIwV//SUae2eH38IXQdfZOZaEMskiGc5r6fGGY2xzB4dT4XVKHSvwqkk921BKGU18TYg2oBUtYXYIrXRWzp/TeFyQ/fbzPbM+kqHQBSmBa/BAo0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CsQoWzLj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CsQoWzLj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description;
	bh=PWKFBKSWC/uFjStoZBpzoea1vU2a1UmxuNyKUMnJ7rk=; b=CsQoWzLj/qz8lhoDxI7c/zasr7
	lY04Jz94bIfHI+SuLwq2svSl+nAtrN2Xp/6UR9ZMC933oTLdBTqFHeHSclqep5+YbtGpFFb2SZAuy
	X0OFVKEZ3xjGT48igJwN/vwuKHtMbxRRAUaHgPre/XYnlVTRWIUQ+NORdBpD2GPiAkNrTGkHQSJ6f
	7u6jtS6qpRd/D0e5hElHBhCpd5xWp8dMaTciKcezMbmRsPaGviGGCmYW/SjwIjrvBM8zBpDE5rD7j
	8zAkWod01MpN6vm1n+z9YgS4Cb7knHZiwEnGTehOMq4X1r0I6+rVQkq+qUh24xqPVfkyVAxI6FOFQ
	tMlvcBgw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <ukleinek@debian.org>)
	id 1slmCx-003IMa-E9; Wed, 04 Sep 2024 09:21:47 +0000
Message-ID: <b973fec7-7722-45b4-91df-c540a6e91c9d@debian.org>
Date: Wed, 4 Sep 2024 11:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ Patch 001 ] feature: add support for loongarch
To: Dan Carpenter <dan.carpenter@linaro.org>,
 wuruilong <wuruilong@loongson.cn>
Cc: linux-sparse@vger.kernel.org
References: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>
 <f687e64e-d653-46a3-a302-68aa4a021215@stanley.mountain>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>
In-Reply-To: <f687e64e-d653-46a3-a302-68aa4a021215@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: ukleinek

Hello Dan,

On 9/4/24 07:39, Dan Carpenter wrote:
> On Fri, May 24, 2024 at 10:47:23AM +0800, wuruilong wrote:
>> +const struct target target_loongarch64 = {
>> +	.mach = MACH_LOONGARCH64,
>> +	.bitness = ARCH_LP64,
>> +
>> +	.big_endian = 0,
> 
> No need to initialize things to zero.

While your concern is technically correct, mentioning it explicitly for 
a human reader is still nice IMHO.

Best regards
Uwe

