Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46131245033
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215097; cv=none; b=W9unKBcWeWHpiCOcaPTScPBRP9C0mMxIQ+mG7nyHaTCch4eaL7aUkmc0ejkPiV3mx4V8RrG8nhg8opmDPsdXFVOxUbmyFhNx0rKrODkqbKJknU14fKvTqzJF1XGkTM4jnQrTRi+rAXnn4DhHJOpGWvZq6i01aVAWyQ1TjW7E6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215097; c=relaxed/simple;
	bh=845E/GYem4ocwcC6ZxutygUycuFuqtbVGLYUqm9Lqkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ac2SQbQWzn7l0Q08zBuy4wKW3RurtByUo0yKQwCck4Hgndq1Z3lQ0/Ph6ETXj0Rx7q7s6glJxmoB5hJaqEEPdcr9dHhyP/p4Ziz5BNDOoO4Zey9Fq/nbk+ZHZyRmcCGmwxjIIAJ/vp1fNDWNdF0wZkxPPyoVZylnY1ahMqVixtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=qhN6oSFe; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="qhN6oSFe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pogIQp4R3ytY5AWCKEeDRevnAVMb7SpAg5KQu/tZu8E=; b=qhN6oSFeR6QKeKeE+YnNNINWLh
	yzU19UnTRhSu+ylQG5NUQmYbH5wopfBufQkp8bfyRYFrbsXfw/Hl3QHGe81ryPCW7OTcPQnHdLV1v
	gNp5XP6MPtQStmwRl1nZORg9PfCy97wmjaMn6Ld3XMyYwWmX7t+TqA0kE+Ll/nSBFmd4jJb0GMppq
	c9GQNVNZ2oq8lUa1AmzlhFFe29GC5OBkmeisHvsxZ/CvjsvUWV8MMbN67gN9lCXj5oLbQ3d7Q2PYK
	MJVQWsobfi0EtbXuxIY+hzD7J+2Yw+xDwn+SBkvX4Ls4XJKtjyUrtxs9RDv/lizI3ymhJXIUGOoqY
	TAIfGWOA==;
Received: from [167.98.27.226] (helo=[10.35.4.166])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uzI3k-001Pzh-S2; Thu, 18 Sep 2025 18:04:41 +0100
Message-ID: <09ad6661-ce61-4d60-b184-943a468c0f9b@codethink.co.uk>
Date: Thu, 18 Sep 2025 18:04:40 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sparse maintainership
To: Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 18/09/2025 16:44, Chris Li wrote:
> Very sorry that I disappeared from the project for a very long time.
> 
> I was the sparse maintainer until someone really wanted the sparse
> project maintenance and fought me over it.
> 
> I was deeply wounded at that time and felt sick of the situation. I
> pulled the plug completely, I stopped caring.
> 
> I was afraid to click on the sparse mailing list folder, even though I
> am still subscribed to it, like a wounded puppy afraid to lick the
> wound. I can observe the number of unread emails in the sparse folder
> is growing, I assume the project is doing great with the new
> maintainer. I am afraid to look inside.
> 
> I accidentally clicked on this folder today. To my surprise  the
> project seems unmaintained.
> That breaks my heart, again.
> 
> I would like to get some clarification on the mailing list:
> Is the sparse project still maintained? I really don't want to step on
> anybody's toe.
> 
> If not, does anyone mind if I slowly resume some maintainer duty at a
> very very slow pace?

You've reminded me I never got the va_args code merged.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
