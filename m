From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [ANNOUNCE] Sparse v0.6.2-rc1
Date: Mon, 15 Jun 2020 18:38:52 +0200
Message-ID: <CAExDi1RbuRvkQb0DAYZUdwj+XQvVn91D8rU_-_bkybfCqi10eg@mail.gmail.com>
References: <20200613020735.iqb2vd23jpomisbq@ltop.local> <c80024d2-6d91-4fe7-a919-3edcf4a9b80a@ramsayjones.plus.com>
 <20200614215445.rtfbx23ve57fhlbr@ltop.local> <d540f450-c72e-5c51-ffba-32d7eb800137@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQjE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 Jun 2020 12:39:04 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B20BC061A0E
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 09:39:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id r11so9733063vsj.5
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 09:39:04 -0700 (PDT)
In-Reply-To: <d540f450-c72e-5c51-ffba-32d7eb800137@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 15, 2020 at 12:37:28AM +0100, Ramsay Jones wrote:
> I just installed python-sphinx (on LM 19.3 it is the python2
> version) to give it a try, and it failed:
>
>   $ make html
>   Running Sphinx v1.6.7

This is probably too old (running 3.0 here but IIRC 2.7 or
2.8 should be OK).

>   making output directory...
>
>   Extension error:
>   Could not import extension cdoc (exception: cannot import name switch_source_input)

Ah yes, I forgot about this one.
This is a very small python module I created to extract the
doc from the C files. It's the file Documentation/sphinx/cdoc.py.
There is another one (ir.py) to keep the IR doc bearable.
Both are specified on the top of the config file
(Documentation/conf.py) which should give the info needed
to load them.

After checking, IIUC, switch_source_input exists only since
Sphinx 1.7 (and it's used by this extension only recently because
AutoReporter was obsolete and was removed in recent versions).

> It's too late to try and fix it tonight ... (also LM 20 is currently
> in beta, so I will be trading up soon) :D

Yes, sure :)

-- Luc
