From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH v3] Add -ftabstop=WIDTH
Date: Thu, 8 Jan 2009 12:13:11 -0800
Message-ID: <70318cbf0901081213i22dc8054yda4230e8a6375e9a@mail.gmail.com>
References: <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
	 <20090108191748.10635.63257.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:46667 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762381AbZAHUNN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 15:13:13 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3311382fgg.17
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jan 2009 12:13:11 -0800 (PST)
In-Reply-To: <20090108191748.10635.63257.stgit@vmbox.hanneseder.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Junio C Hamano <junio@pobox.com>

On Thu, Jan 8, 2009 at 11:18 AM, Hannes Eder <hannes@hanneseder.net> wrote:

> +
> +       if (!strncmp(arg, "tabstop=", 8)) {
> +               char *end;
> +               unsigned long val;
> +               arg += 8;
> +
> +               if (*arg == '\0')
> +                       die("error: missing argument to \"-ftabstop=\"");
> +
> +               /* we silently ignore silly values */
> +               val = strtoul(arg, &end, 10);
> +               if (*end == '\0' && 1 <= val && val <= 100)
> +                       tabstop = val;
> +
> +               return next;
> +       }
> +
> +       /* handle switches w/ arguments above, boolean and only boolean below */
> +
>        if (!strncmp(arg, "no-", 3)) {
>                flag = 0;
>                arg += 3;

Is that the only portion that get changed between v2 and v3?
It took me a while to realized what really get changed here.

I suggest a new function: handle_switch_ftabstop() here.

Then we do:

        if (!strncmp(arg, "tabstop=", 8))
            return handle_switch_ftabstop(arg+8, next);

It will make handle_switch_f cleaner.

I already apply your V2 patch. Can you make this change
an incremental patch against my tree?

Thanks

Chris
