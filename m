Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B8883B
	for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2023 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+c0ET/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5185EC433C8;
	Thu, 28 Dec 2023 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703773290;
	bh=V5AA1DqqNKqu26CoSqIwcvEzbsyFIj01Dus6yGDPPpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+c0ET/nDQjwdguUzH6QXzIpAHxaTgZeXJsZwfn9LYUdNNr4NcX8s6J3cuEBLaFdC
	 ztX7PpxIf2wH295ZiziZ0CtyxmsXBoTfoDErzcbU0NTId5bh8r34SJtAcQn0yIwf3R
	 d1a1qAF9Mj24Z3PEVPBhspEt0tK1zJ4gPHAfPxxQvWf77JOxyhTnOzcGkLgoZ9FXGy
	 qVQC7LS5O13zMsBjdez4EysHU7nQd9Nm8zvEC+vDfTtIeC5WPtyNxwPUnedpS2ltbT
	 eOM6MFLRSThEQPOE+FJBT/xb08VkW+mvtZCL8WHO8/0jcFPULprgaMQA0guPa7RMlo
	 zcaII3XMRnqSQ==
Date: Thu, 28 Dec 2023 15:21:22 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: "Herbert, Marc" <marc.herbert@intel.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Re: Infinite loop in delete_pseudo_user_list_entry() bisected to
 commit "cast: optimize away casts to/from pointers"
Message-ID: <hgs2cgb2auv5y3apocuig6xjhmv3oy5hbzmvjxrxoharjb3fzy@mhjaitwlrnvy>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
 <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
 <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
 <4EB87136-D1B0-41CF-B552-9E9F19C00F3B@intel.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB87136-D1B0-41CF-B552-9E9F19C00F3B@intel.com>

On Thu, Dec 28, 2023 at 01:08:27AM +0000, Herbert, Marc wrote:
> 
> More good news: running `sparse tls.i` on this pre-processed file
> reproduces instantly for me.

Nice!
 
> So see tls.i file below. In case my mailer mangled the file (I gave up
> on plain text email a long time ago, sorry about that) I also attached
> it to the issue:
>   https://github.com/zephyrproject-rtos/zephyr/issues/63417
> I doubt this list accepts attachments...

No problems, I got it alright, thanks.
I think that not too long text attachments (<20M) are OK but I may be wrong.
 
Anyway, with this it was very easy to reproduce and find the cause.
Fixed and pushed, so mainline Sparse should be OK now.

Many thanks for the bug report,
-- Luc
