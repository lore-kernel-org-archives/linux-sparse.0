From: Eric Biggers <ebiggers@google.com>
Subject: Development version of sparse?
Date: Tue, 11 Oct 2016 10:21:01 -0700
Message-ID: <20161011172101.GA126173@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36684 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbcJKRVI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Oct 2016 13:21:08 -0400
Received: by mail-pa0-f44.google.com with SMTP id ry6so18126423pac.3
        for <linux-sparse@vger.kernel.org>; Tue, 11 Oct 2016 10:21:08 -0700 (PDT)
Received: from google.com ([2620:0:1008:1201:fd63:4ad9:e125:b3dc])
        by smtp.gmail.com with ESMTPSA id n77sm5644636pfi.82.2016.10.11.10.21.05
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 10:21:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I found that the "official" sparse repository,
git://git.kernel.org/pub/scm/devel/sparse/sparse.git, only contains patches up
to January 2015.

There is another repository, which was more difficult to find, which contains
some more recent patches, but only up to January 2016:
http://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

There have been a number of useful patches posted to the mailing list since then
which don't appear in either repository, such as fixing the prototype for
__builtin_object_size().

Which one, if either, is currently the "official" repository for sparse?  Is
Chris L. still the maintainer?

And if the official repository has changed, can we get some of the links
updated?  For example the one on
https://sparse.wiki.kernel.org/index.php/Main_Page.

Thanks,

Eric
