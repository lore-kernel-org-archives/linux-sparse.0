From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 04:24:00 +0300
Message-ID: <f19298770812171724k6411542fq5baf361d481f927c@mail.gmail.com>
References: <20081217190534.24084.94887.stgit@zaytsev.su>
	 <49498C67.4000700@cowlark.com>
	 <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com>
	 <4949A03A.5060309@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:12918 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYLRBYD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Dec 2008 20:24:03 -0500
Received: by fg-out-1718.google.com with SMTP id 19so87289fgg.17
        for <linux-sparse@vger.kernel.org>; Wed, 17 Dec 2008 17:24:00 -0800 (PST)
In-Reply-To: <4949A03A.5060309@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Thu, Dec 18, 2008 at 03:58, David Given <dg@cowlark.com> wrote:
> Alexey Zaytsev wrote:
> [...]
>> Please, sign off this patch and the one adding type information to
>> struct instruction.
>
> I'm sorry, I didn't realise you were talking to me!
>
> What do you want me to do? I don't know anything about the sort of
> process you use.
>

Short: You add 'Signed-off-by: David Given <dg@cowlark.com>' to the
end of the patch description. Or if you forgot to do so, you can reply
to the email with this line and the maintainer will add it to the
patch description for you. This bascally means that you are OK with
your work being merget my other people, and also helps to track who
made which changes/bugs, statistics, etc, and some even see it as
having some legal power.

Long: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/SubmittingPatches;h=f309d3c6221c3699a0c0b97fbe689faed09e4d2f;hb=HEAD#l282
Sparse seems to use the same procedure as the kernel.
