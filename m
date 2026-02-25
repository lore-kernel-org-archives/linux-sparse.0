Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699482135C5
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990450; cv=none; b=Ehtkgwhmorbw5CZyAKJwtMFX3IneacdxkTESg+yMG5F05PBXFUqf1cSIJqlgSA4Rxt5S+AFgX3DoNj6Ye3wDQ6gpU3TOQKi1rtAAkN7pYRt8J7PZ/4Gj7u2B8gEA7vqTBbsZzrkxsQZJLKSyChQfQzO3hfBkLG/+zlAGXIQYGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990450; c=relaxed/simple;
	bh=tonUli3ZBnbXrIMEiKxQr3sfc/nIOVEB+1GOE7je3QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc+PZzxc56GNExjKLkaaMX51YTVBu9WXOtWE5I6Bc91QMQtXpFlZV6s4vc0gbET/MO1rejRvZ9dpzYHDl8N/4uw8XaDopmTPcFB9AOawcJsrFsnZvnnKbcySBV6a8pp45Jol1FQgCWnb37bbolNq4Dxf2n3i8xEE0o3mQfzJWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Kiwn4FDf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kiwn4FDf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=67OMln7hcg7mRUIkxxQoGwxhG+PZp/VmZ5rIrttGNQc=; b=Kiwn4FDf+qc1TzcBDAOowPIzZB
	qIre0vGObOPiqNWGqUFskxX8PiVAKBP0zDq+GnblmDDIxRf3UPKGrv8mo/P7WWG94FzQ1cIGusMUF
	7eg7U3Njv+EG6dmzeuOtBwsVLG/Lymo9YutDZP8gQ5u1lZjK95W0TqzNFQCcwmyxya4NwJ3CE7bxK
	TnWI+OuCTK8zdRRcRU16AXhBpRzsBq0bZjiuUyVP2cq/WZuM+y6TP2uwhaE9cttuXF9M2/UhBRpfw
	UKNAGJhoenUQYmac+zPlbVE+RqfuX4HHiyuFeVgtCVntxiufiBpgxdQs0JMb0gzKXjo01WYc/YszH
	0GCjAu5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vv5hX-0000000CIyi-0zrF;
	Wed, 25 Feb 2026 03:36:39 +0000
Date: Wed, 25 Feb 2026 03:36:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chris Li <sparse@chrisli.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-sparse@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Xuanhao Zhang <zxh@xh-zhang.com>
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
Message-ID: <20260225033639.GA2924820@ZenIV>
References: <cover.1771930766.git.dan.carpenter@linaro.org>
 <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
 <CACePvbUjNQUZWcTK-59p09RJAjZZs+z8HuYmkfeTXWBsOKBEfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbUjNQUZWcTK-59p09RJAjZZs+z8HuYmkfeTXWBsOKBEfw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 24, 2026 at 06:39:57PM -0800, Chris Li wrote:

> > I guess if you wanted instead of a comma then you could have an empty
> > __VA_OPT__() or you could pass random things like __VA_OPT__(a b c).  I
> > don't know why you would do that.  In this case, "a" is a macro argument
> > so that has to be expanded out.

<sarcasm>
Then perhaps reading the standard might prove enlightening - possibly
due to examples that might be in there, or seeing the actual description
of semantics?  https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf
is there and searching for __VA_OPT__ would immediately get you this:

#define SDEF(sname, ...) S sname __VA_OPT__(= { __VA_ARGS__ })
SDEF(foo); // replaced by S foo;
SDEF(bar, 1, 2); // replaced by S bar = { 1, 2 };

Would that answer your question?
</sarcasm>

> One idea is to add an expand function expand___VA_OPT__, similar to
> expand_has_feature(). Register it in the dynamic expand macro array.
> That way you get the collect_arguments() for free and it behaves just
> like a builtin macro expansion. Just duplicate the collected arg list
> to the current token, if  there are extra arguments.

Sorry, no go; for one thing, #__VA_OPT__() won't be dealt with that way,
for another there's fun with foo ## __VA_OPT__(arg) (argument is expanded
*and* subjected to ## - yes, it's possible now).

I have something resembling a workable approach, but there's nasty corner
case when you mix it with the side effects; that's impossible in standard
C, but gcc has the sodding __COUNTER__ thing and _that_ makes life really
interesting.

If there's __VA_OPT__ in the body, we want to expand vararg whether it
occurs in the body or not.

We want to expand each argument that is present in the body.

Question: should we expand an argument that occurs *only* under __VA_OPT__?
Note that "expand and discard" is *not* a no-op - expansion of __COUNTER__
will have visible side effects.  What's more, gcc and clang diverge there.

Another kind of side effect is possible in standard C: argument substitution
might fail when attempted.  And gcc is arguably broken there - see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=123325 for fun details.
clang handles that one sanely...

I got stalled waiting for gcc folks to respond, then sidetracked to other
stuff.  I'll resurrect that stuff later this week.
