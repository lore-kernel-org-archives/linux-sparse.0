From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 21:25:40 +0200
Message-ID: <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com> <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33033 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdHQTZl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:25:41 -0400
Received: by mail-oi0-f51.google.com with SMTP id f11so76559182oic.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:25:41 -0700 (PDT)
In-Reply-To: <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 9:21 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>> Apart from that I faced a problem with this and had to disable
>>> STRUCT/UNION from being treated as simple types.
>>
>> That's only a problem/a limitation of your backend.
>>
>
> Possibly - I haven't checked yet. Are you able to generate code / and
> run the test case using your LLVM backend?

Possibly not but you're the only use of the LLVM backend, so it's yours ;)

-- Luc
