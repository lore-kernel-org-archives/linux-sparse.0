From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: new feature " multiple initializers" has false positives
 on MODULE_ALIAS
Date: Fri, 23 Jan 2015 08:40:17 -0800
Message-ID: <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
References: <54C15E0E.4000008@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:58869 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbbAWQkS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 11:40:18 -0500
Received: by mail-qc0-f181.google.com with SMTP id l6so7093182qcy.12
        for <linux-sparse@vger.kernel.org>; Fri, 23 Jan 2015 08:40:17 -0800 (PST)
In-Reply-To: <54C15E0E.4000008@de.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jan 22, 2015 at 12:31 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Linus, Christopher,
>
> Commit  0f25c6a78e08fdc15af5e599d836fa24349c042f ("Add warning about duplicate initializers") has a false positive on arch/s390/kvm/kvm-s390.c
>
>   CHECK   arch/s390/kvm/kvm-s390.c
> arch/s390/kvm/kvm-s390.c:1823:1: error: symbol '__UNIQUE_ID_alias__COUNTER__' has multiple initializers (originally initialized at arch/s390/kvm/kvm-s390.c:1822)

Search the "__COUNTER__" macro shows that:
https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html

__COUNTER__This macro expands to sequential integral values starting
from 0. In conjunction with the ## operator, this provides a
convenient means to generate unique identifiers. Care must be taken to
ensure that __COUNTER__ is not expanded prior to inclusion of
precompiled headers which use it. Otherwise, the precompiled headers
will not be used.

I think sparse haven't implement the __COUNTER__ macro. That is why it emit the
error on duplicate entry.

Chris
