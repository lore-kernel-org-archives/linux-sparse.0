From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH][RFC] handle -I and -include combination
Date: Tue, 26 Jun 2012 00:52:35 -0700
Message-ID: <CANeU7Qm=0cCqHRJpDxeRK=QmqpJRyXu9wo1tKzCQqSxsQ_dLqQ@mail.gmail.com>
References: <1340023258-7069-1-git-send-email-kosaki.motohiro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39806 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab2FZHwf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2012 03:52:35 -0400
Received: by yenl2 with SMTP id l2so3524803yen.19
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jun 2012 00:52:35 -0700 (PDT)
In-Reply-To: <1340023258-7069-1-git-send-email-kosaki.motohiro@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: kosaki.motohiro@gmail.com
Cc: linux-sparse@vger.kernel.org

On Mon, Jun 18, 2012 at 5:40 AM,  <kosaki.motohiro@gmail.com> wrote:
> From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
>
> Currently, "-include" behavior is far different between sparse
> and gcc. gcc can compile following testcase. but sparse can't.
>
> This patch fixes it.
>

Thanks for the patch. The patch has some small problem though:
There are some other user of the cmdline_include array.
Remove it will disable those options.

Also the include order of the header file is now reversed:

$  gcc -include a.h -include b.h  foo.c
will include a.h then b.h.
Your patch will include b.h then a.h.
Granted, the "isystem" has the same bug here too.

Chris
