From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: bit-field notation and k&r function syntax
Date: Thu, 4 May 2017 01:07:22 +0200
Message-ID: <20170503230721.vb4aunmpaa2xxaf2@desk.local>
References: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
 <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33694 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdECXHZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 19:07:25 -0400
Received: by mail-wr0-f176.google.com with SMTP id w50so1884115wrc.0
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 16:07:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 03, 2017 at 01:10:12PM -0400, Lance Richardson wrote:
> I noticed when browsing parse.c that function parameters declared
> using K&R syntax are parsed by calling declaration_list(), which
> seems to have been intended for parsing structure member declarations
> and accepts bit-field syntax.
> 
> So e.g. this is (incorrectly) accepted by sparse:
> 
> static int foo(b)
> int b: 4;
> {
> 	return 0;
> }

Hmmm yes.
What's sparse use 'declaration_list()' for is not what correspond
to the standard's 'declaration-list' but is indeed for something
that should be reserved to structs.

Nice catch.

-- Luc
