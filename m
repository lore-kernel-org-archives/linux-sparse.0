From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/5] Makefile: suppress error message from shell
Date: Tue, 21 Jul 2009 17:35:46 -0700
Message-ID: <70318cbf0907211735t6e279f5ag5602abd54f94656f@mail.gmail.com>
References: <4A6233D0.1060502@ramsay1.demon.co.uk>
	 <20090719140316.GB25417@feather>
	 <70318cbf0907201321y26cba10h2d77d7ae02d86090@mail.gmail.com>
	 <4A663817.8040503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:43762 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZGVAfs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 20:35:48 -0400
Received: by qyk3 with SMTP id 3so1420395qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 21 Jul 2009 17:35:46 -0700 (PDT)
In-Reply-To: <4A663817.8040503@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jul 21, 2009 at 2:50 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
> Hmm, I noticed that you edited the "subject line" when you applied
> the patch; namely s/shell/pkg-config/.
>
> I find this a little puzzling, since the error message *is* issued
> by the shell and is definitely *not* issued by pkg-config... which
> is kinda the point... ;-)
>
Oh, right. The error is issue from shell when it try to run pkg-config.
If I just read the title, it is hard for me to predict where the change
is going to be. I just want to be more specific.

There is a reason I haven't push those to official tree yet. We can
still change it if we want. Suggestion?

Chris
