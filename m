Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7B4D9900
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661508; cv=none; b=E/7lWTdURF5m6zVt5C2alFVoCi++DWjaGx1CRjWY7Snw4C0kvMxJTC8FPstTCfrXJC3Fej13aBU/WEx7JbyqZ/gYj8vcIOOgnPIHAuJetN0/72QcZ/2f4Y6ncAUG//yhTtYV7Vga8WJVykyo7Xbfu+OeAnoWSjxI92ihUWILsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661508; c=relaxed/simple;
	bh=PQdPmN8Q5z7jRLCtgU8LzrTi+vdtT+ef2a6OL92I1zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfZSEWfF/cpgXmPkmlzLzxTPGcyVu5zVJdD5+HyA+vydzczqTvYvthcsP7khGv4SQDxMqeWpsTrDjSxIxKBoFc38UfBMfyJxRm59Egyvd28o2tLmcscKDjoQQHAjKN+IopZRnVe5nZpAK5S7Kc3hC9JXaEUHk+JfjEi6R8VgWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk; spf=pass smtp.mailfrom=knosof.co.uk; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knosof.co.uk
Received: from [188.214.11.109] (helo=[192.168.50.78])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1wVS0z-0000000BpZT-1qyU;
	Fri, 05 Jun 2026 11:43:01 +0100
Message-ID: <3b932ec5-4ec2-41f9-bdab-a54ece42d745@knosof.co.uk>
Date: Fri, 5 Jun 2026 11:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: declarations after a case statement
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org
References: <aiGAXJhYJoUuqB5j@stanley.mountain>
 <aiGCMuw3Lblnc9TA@stanley.mountain>
 <fe4a18e2-c398-4a3a-b8ca-be9e7ed33ba7@knosof.co.uk>
 <aiJjrf-X8zB7fLWI@stanley.mountain>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <aiJjrf-X8zB7fLWI@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dan,

>> Sparse is correct.  The usage you describe is a syntax error.
>>
>> A label may only appear on a statement, not a
>> declaration
>> https://c0x.shape-of-code.com/6.8.1.html
>>
> 
> That's an awkward thing because GCC allows it and the kernel is
> doing it.

Double checked.  I'm out of date.  C23 supports the labeling of declarations

6.8.2p4
Any statement or declaration in a compound statement can be preceded by a prefix
that declares an identifier as a label name.

Sorry for confusion.

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

