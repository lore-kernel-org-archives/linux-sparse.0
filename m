From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH][RFC] handle -I and -include combination
Date: Fri, 29 Jun 2012 17:27:32 -0700
Message-ID: <CANeU7QmVqaQVKEc-9O28J8Z5Hvy20DYffqVz7yHknoouHVC+fQ@mail.gmail.com>
References: <1340023258-7069-1-git-send-email-kosaki.motohiro@gmail.com>
	<CANeU7Qm=0cCqHRJpDxeRK=QmqpJRyXu9wo1tKzCQqSxsQ_dLqQ@mail.gmail.com>
	<CAHGf_=oozZQZtyQow1GocS-=o8EiXctCP1HBa7Y7kMgCG58x6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f42.google.com ([209.85.213.42]:53701 "EHLO
	mail-yw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab2F3A1d (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 29 Jun 2012 20:27:33 -0400
Received: by yhfq11 with SMTP id q11so4751231yhf.1
        for <linux-sparse@vger.kernel.org>; Fri, 29 Jun 2012 17:27:33 -0700 (PDT)
In-Reply-To: <CAHGf_=oozZQZtyQow1GocS-=o8EiXctCP1HBa7Y7kMgCG58x6A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 27, 2012 at 10:55 AM, KOSAKI Motohiro
<kosaki.motohiro@gmail.com> wrote:
> If I understand correctly, cmdline_include is only used from -include
> and -imacro. and, -imacro is also needed to respect -I. Am I missing
> something?

Actually, I misread your patch. You patch function fine.
The only thing I might change is the name of the "pre_buffer2".
If this buffer is only use by the include files, we might just all it
include_buffer or some thing like that. Let me know if you want to
resend one with a better name, or I can patch it for you.

Thanks for the patch. That will get rid of the static array as well.
Nice.

Chris
