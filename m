Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AF656
	for <linux-sparse@vger.kernel.org>; Sat, 20 Jan 2024 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714046; cv=none; b=jhZ7t31syCkfEFXkvQYLBr59+9ThGWWanT2CkJ+suk+EW5Zk7p5pHlmxjZEzYYxAgS4/1hOGjH3dcG0v4xOm+FVCz5RFpEtGcHK48iTjOB0y1SFFfua2dlTYPudFXSpg1IF1f2FT6TIFgoDBaivsZ6rQpRM8Oip25ueWOwjSTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714046; c=relaxed/simple;
	bh=fP2lQ05JYexzgTzqMqEv5axtAi5sVMJjWeISRjZSlGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHc4BClyrINZt68cvSsHW2gvEsQyAp8hlL7w00XQkG+vNCB+tafhGMXLcP3jp/h3Ij/e5D8MVHWjCJIYA1/eKXNXwGUAow1mPqxPKNw/Q7DQ52kjubOGNcpE47F7tOMnDCRDXK+Fyw23neiygYt3VEhY/drocJ7cmSWe0UfSaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTJcyv/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTJcyv/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C42C433F1;
	Sat, 20 Jan 2024 01:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705714046;
	bh=fP2lQ05JYexzgTzqMqEv5axtAi5sVMJjWeISRjZSlGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTJcyv/7fdazAWpmXIyV+SsBpynx4eWLt2Js3XaMMzraKK8ZeVEhvYDQ3ArZKKYRw
	 y9m0vC94/D1VROJ/U4DFYcaV4YWvVLTCMQWTrdDr/GBUggbyfEy6KV/KsYTJ0uu/3u
	 Pp13n0AGrDGbQSVWC7OzH0tmLmChGsOcSIGbF8krW1odpNpEF0o94v9DtQpUGDlqCW
	 IkLxsOQEhiJUVZ/SHoTHZjDUJetwRI+SKh7ONY9mQoj4ojHnESv1F6aV8KbUGbIIzU
	 XXH5KIfqI3H2JEn0ieDC5eD8STWYTekzMHsqoLd0JKja/7bf0lNdk/PbAwQ71ti6tO
	 nTKRGhlFoJsEw==
Date: Sat, 20 Jan 2024 02:27:17 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: "Herbert, Marc" <marc.herbert@intel.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Re: Christmas wish list: -Werror and -Wno-warn-about-X
Message-ID: <3eifvstptigzcjthdjwshxxxqtn3yjtm4jifhs4sqcsrqhozjh@6ixifzmsekkq>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
 <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
 <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
 <4EB87136-D1B0-41CF-B552-9E9F19C00F3B@intel.com>
 <hgs2cgb2auv5y3apocuig6xjhmv3oy5hbzmvjxrxoharjb3fzy@mhjaitwlrnvy>
 <28F15CC0-6BCF-411C-8481-9EC8900B8372@intel.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28F15CC0-6BCF-411C-8481-9EC8900B8372@intel.com>

On Fri, Jan 19, 2024 at 11:09:47PM +0000, Herbert, Marc wrote:
> 
> > Anyway, with this it was very easy to reproduce and find the cause.
> > Fixed and pushed, so mainline Sparse should be OK now.
> 
> > Many thanks for the bug report,
> 
> Fix confirmed, many thanks for the super quick fix!
> 
> It's also great to see that you seem to have more time to spend on
> sparse right now.

If only ...

> So trying to push my luck, here's the number 1 item on
> my "Christmas Wish List": a combination of -Werror and -Wno-warn-about-X
> options that would provides finer-grained and generally better control
> on the exit status and output. After maintaining sparse automation for
> many months, this is I think what would lower the CI adoption bar the
> most.

Yes, I can understand that.

As far as I understand it, -Werror has been replaced by -Wsparse-error in
2014 because sparse was mainly used with exactly the same options as the
ones used for the compiler (which is good), there was too much error
messages and people didn't want to have their build to fail (see commits
4d8811879a1c & fe57afa0b44a). So, essentially the exact opposite of what
you would like :(

-Wsparse-error is really a pain because it also turn every warning into
an error (and then exit on these errors).

It should indeed be possible to have an exit(1) on errors but I'm very wary
of changing the current behaviour. What about something like -ffail-on-error?

> So far we've been using a brittle script that captures the incredibly
> verbose and mostly unusable output (mostly due to some hard-to-fix
> warnings located in common .h files) and "post-processes" it
> with... "grep".
>  https://github.com/thesofproject/sof/commit/b7708182fbe5d
> 
> I'm curious how people typically automate runnning sparse on the
> Linux kernel. Does everyone "greps" logs too? Or is it more like
> `$(wc -l) == 0`?

I think so (but I could be very wrong). An exit on error is only useful
if the output is clean and the errors not too frequent. I think it's
often not the case.

But, if your main problem is with error messages concerning address spaces,
have you tried to simply use -Wno-address-space?

Some other error messages issued by sparse can't be disabled but most of these
are, I think, parsing or typing errors that are more or less unrecoverable.

Purely for my own curiosity, could you send me one of your log of sparse
errors?

Best regards,
-- Luc
