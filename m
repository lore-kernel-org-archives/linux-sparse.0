Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1C366DDE
	for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931820; cv=none; b=Q2ZjucPl+IJPM5jr9af1xTyO9HXny+WtgXFS9Z/OzHi0/df5uYhcbbI/7DqcyuiW0D0p8eJOyJdiGwEtttLTPo3P6vbAFDmEEmlSr7cIjx3ACVKQcuHrYsFnDa9wO7cVVq+WyXlHLBDWAJeDQNDK2Tk46gJipEgtsELYXQeiJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931820; c=relaxed/simple;
	bh=3DNAJMpIO7UfCIAb1Htl03Pg/pN2v2D/QAGakYHEEvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOss4HGSQ9vR29z2oPo24HfNdwpiMY65b6G8kJuf7KHx/8DSpcbncDCXNjubNQBjamdN77L14VwCnWymIidehtSRtvAICZkbbIUaWHGlJKVGxHcbiUdMKYMoCZDT/A4hXaVRHOyTlOVfih3YnJNNyGmnM9ZITjWadMTWo1SDy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=aryjIB84; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="aryjIB84"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=AYmUbZLrio0A5G41Blrm/eYXbL8kA5zJQXDgG2pyVCM=; b=aryjIB8420xrCIf1
	2tftnqgI6Rw2qDEOYnVp/gfXGs5XSbbJfSh0/j4m5VxiJTMVDzqH8seU029qZh33QVfKF1+ULPJX5
	WYdwyMwEk1hj8hSODGyvbkOrrWO6Q/fN7VZX6stmP/OQKHnLK836N3gMI0KRKVrhnnDOAXRRCDQCu
	n140sc88DB1WUSE1nciqaATn/9Tu0/qVZrfVsvL2CWxAAZbjO8uuV8z81ifSxFBTZ9B9lZAWSOdLb
	snqT9MtpYREkG16s9sEDiyUwT1oM1Rzu8qSpqByBgUkUQShO3Oau78odT9EaBlR+ECkir/8aGGmdI
	/kzmbqxH6Cnn/pK3AA==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vuqPJ-00CUaX-1q; Tue, 24 Feb 2026 11:16:49 +0000
Message-ID: <29424a96-4c7c-4076-99bc-903cd857f89a@codethink.co.uk>
Date: Tue, 24 Feb 2026 11:16:48 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-sparse@vger.kernel.org,
 Chris Li <chriscli@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Hans Verkuil <hverkuil@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
References: <cover.1771930766.git.dan.carpenter@linaro.org>
 <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 24/02/2026 11:07, Dan Carpenter wrote:
> The linux kernel has started using __VA_OPT__ so lets add support for it.
> 
> What it does is it adds an optional thing, normally a comma, if the
> __VA_ARGS__ parameter is not empty.  So if you have at least one argument
> but possibly more then you could create a macro like:
> 
> #define test_args(a, ...) printf(a __VA_OPT__(,) __VA_ARGS__)
> 
> If you call test_args("foo\n") it expands to:
> 
> printf("foo\n");
> 
> but if you pass two arguments test_args("foo %d\n", 2) it expands to:
> 
> printf("foo\n" , 2);
> 
> I guess if you wanted instead of a comma then you could have an empty
> __VA_OPT__() or you could pass random things like __VA_OPT__(a b c).  I
> don't know why you would do that.  In this case, "a" is a macro argument
> so that has to be expanded out.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
This wouldn't apply to the current tree using git-am.
Current head for me is 37156835e3d725b6d750f000be33ba3814bb2310

$ git am  < \[PATCH\]\ sparse\:\ add\ support\ for\ __VA_OPT__\ -\ Dan\ 
Carpenter\ \<dan.carpenter@linaro.org\>\ -\ 2026-02-24\ 1107.eml
Applying: sparse: add support for __VA_OPT__
error: patch failed: ident-list.h:66
error: ident-list.h: patch does not apply
error: patch failed: pre-process.c:643
error: pre-process.c: patch does not apply
Patch failed at 0001 sparse: add support for __VA_OPT__


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
