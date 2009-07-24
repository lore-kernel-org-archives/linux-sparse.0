From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/5] Makefile: suppress error message from shell
Date: Fri, 24 Jul 2009 19:40:22 +0100
Message-ID: <4A6A0016.5030204@ramsay1.demon.co.uk>
References: <4A6233D0.1060502@ramsay1.demon.co.uk>	 <20090719140316.GB25417@feather>	 <70318cbf0907201321y26cba10h2d77d7ae02d86090@mail.gmail.com>	 <4A663817.8040503@ramsay1.demon.co.uk> <70318cbf0907211735t6e279f5ag5602abd54f94656f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:52243 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753972AbZGXTeS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Jul 2009 15:34:18 -0400
In-Reply-To: <70318cbf0907211735t6e279f5ag5602abd54f94656f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Tue, Jul 21, 2009 at 2:50 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
>> Hmm, I noticed that you edited the "subject line" when you applied
>> the patch; namely s/shell/pkg-config/.
>>
>> I find this a little puzzling, since the error message *is* issued
>> by the shell and is definitely *not* issued by pkg-config... which
>> is kinda the point... ;-)
>>
> Oh, right. The error is issue from shell when it try to run pkg-config.
> If I just read the title, it is hard for me to predict where the change
> is going to be. I just want to be more specific.
> 
> There is a reason I haven't push those to official tree yet. We can
> still change it if we want. Suggestion?

I liked the original myself. :)

The "Makefile:" prefix was intended to indicate where the change was
made and I thought that the one-line summary was compact and accurate.

It's a bit difficult to indicate that "the cause of the error, which
is issued by the shell, is a missing pkg-config command on some
systems" as part of the one-line summary. (So I didn't try ;P )

Having said that, I can't claim to be good at writing commit messages.
So, feel free to re-write it as you wish.

ATB,
Ramsay Jones


