From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 1/3] Add -*- gdb-script -*- to the top of gdbhelpers, for
	Emacs
Date: Mon, 1 Jun 2009 21:26:37 +0400
Message-ID: <f19298770906011026k78143216u3384d36b3cdc7e7a@mail.gmail.com>
References: <1243784652-31802-1-git-send-email-naesten@gmail.com>
	 <f19298770905312321q6eedf6e8ge7d5fe5ec46740da@mail.gmail.com>
	 <db65a1cd0906010906x5e3b0044j181159e627b80800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:50311 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbZFAR0h (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Jun 2009 13:26:37 -0400
Received: by fxm12 with SMTP id 12so5939690fxm.37
        for <linux-sparse@vger.kernel.org>; Mon, 01 Jun 2009 10:26:37 -0700 (PDT)
In-Reply-To: <db65a1cd0906010906x5e3b0044j181159e627b80800@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jun 1, 2009 at 20:06, Samuel Bronson <naesten@gmail.com> wrote:
> On Mon, Jun 1, 2009 at 2:21 AM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
>> On Sun, May 31, 2009 at 19:44, Samuel Bronson <naesten@gmail.com> wrote:
>>> Changes-licensed-under: ISC license
>>
>> I don't think it works that way.
>
> Yeah, yeah, well it's a simple permissive license, so even if the
> patch introduced anything copyrightable -- which it presumably doesn't
> -- you could use it anyway.
>
> I just don't feel comfortable contributing under the OSL 1.1, for some
> reason -- possibly because it's considered non-DFSG, possibly because
> it's even more restrictive than the GPL ...
>

I'm not your lawyer, and not the sparse maintainer, but I strongly suspect
that that means that you can't contribute to sparse. And I'm not sure if you
could distribute the patches you sent at all, since they are derivative work,
and should be covered with the same license as sparse itself.

  c) to distribute copies of the Original Work and Derivative Works to
     the public, with the proviso that copies of Original Work or
     Derivative Works that You distribute shall be licensed under the
     Open Software License;
