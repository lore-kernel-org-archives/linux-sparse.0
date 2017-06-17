From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Token stream question
Date: Sat, 17 Jun 2017 11:31:12 +0100
Message-ID: <CACXZuxfUuA_jWOth=R2uRjXKs5pNNMB3Sz79uP7difk7s9WstA@mail.gmail.com>
References: <CACXZuxeq=nJ5P6-0KA+7KQVG7HsWTS+L17LV5Gb=hrDxTSWCOA@mail.gmail.com>
 <20170617100937.alrkuhkyklffgsk7@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34341 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdFQKbO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Jun 2017 06:31:14 -0400
Received: by mail-wr0-f178.google.com with SMTP id 77so49357222wrb.1
        for <linux-sparse@vger.kernel.org>; Sat, 17 Jun 2017 03:31:13 -0700 (PDT)
In-Reply-To: <20170617100937.alrkuhkyklffgsk7@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 17 June 2017 at 11:09, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Jun 17, 2017 at 10:55:30AM +0100, Dibyendu Majumdar wrote:
>> The way I am trying to set this up is as follows. I want to allow the
>> user to provide inputs as files, memory buffer, or a combination. I am
>> trying to process the files first, followed by the memory buffer.
>> Therefore I need to use tokenize_buffer() again when processing the
>> memory buffer - but presumably this ought to get a new stream idx
>> rather than 0?
>
> I think you should quickly be able to set something with:
>         fd = -1;
>         idx = init_stream(name, fd, NULL);
>         tok = setup_stream(&stream, idx, fd, buffer, size)
>         ... = tokenize_stream(&stream);
>

Thank you for the suggestion - will try it out!

Regards
Dibyendu
