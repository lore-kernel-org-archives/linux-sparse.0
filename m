From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Token stream question
Date: Sat, 17 Jun 2017 12:09:38 +0200
Message-ID: <20170617100937.alrkuhkyklffgsk7@ltop.local>
References: <CACXZuxeq=nJ5P6-0KA+7KQVG7HsWTS+L17LV5Gb=hrDxTSWCOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37328 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdFQKJl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Jun 2017 06:09:41 -0400
Received: by mail-wm0-f45.google.com with SMTP id d73so39849332wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 17 Jun 2017 03:09:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeq=nJ5P6-0KA+7KQVG7HsWTS+L17LV5Gb=hrDxTSWCOA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jun 17, 2017 at 10:55:30AM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I am trying to understand how streams are setup, so that I can setup a
> "dummy" stream when handling input that is in a buffer rather than a
> file. I notice that tokenize_buffer() always sets up a stream with idx
> = 0. Does this mean that sparse expects tokenize_buffer() to be only
> used once in the initialize() phase?

Currently it's the only user but ...
 
> The way I am trying to set this up is as follows. I want to allow the
> user to provide inputs as files, memory buffer, or a combination. I am
> trying to process the files first, followed by the memory buffer.
> Therefore I need to use tokenize_buffer() again when processing the
> memory buffer - but presumably this ought to get a new stream idx
> rather than 0?

I think you should quickly be able to set something with:
	fd = -1;
	idx = init_stream(name, fd, NULL);
	tok = setup_stream(&stream, idx, fd, buffer, size)
	... = tokenize_stream(&stream);


-- Luc
