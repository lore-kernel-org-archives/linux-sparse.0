From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Token stream question
Date: Sat, 17 Jun 2017 10:55:30 +0100
Message-ID: <CACXZuxeq=nJ5P6-0KA+7KQVG7HsWTS+L17LV5Gb=hrDxTSWCOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36274 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdFQJzc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Jun 2017 05:55:32 -0400
Received: by mail-wm0-f51.google.com with SMTP id m125so43275934wmm.1
        for <linux-sparse@vger.kernel.org>; Sat, 17 Jun 2017 02:55:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am trying to understand how streams are setup, so that I can setup a
"dummy" stream when handling input that is in a buffer rather than a
file. I notice that tokenize_buffer() always sets up a stream with idx
= 0. Does this mean that sparse expects tokenize_buffer() to be only
used once in the initialize() phase?

The way I am trying to set this up is as follows. I want to allow the
user to provide inputs as files, memory buffer, or a combination. I am
trying to process the files first, followed by the memory buffer.
Therefore I need to use tokenize_buffer() again when processing the
memory buffer - but presumably this ought to get a new stream idx
rather than 0?

Thanks and Regards
Dibyendu
