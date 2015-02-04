From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Wed, 4 Feb 2015 03:38:18 +0100
Message-ID: <20150204023816.GA7731@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
 <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35071 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbbBDCiW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 21:38:22 -0500
Received: by mail-wg0-f46.google.com with SMTP id l2so47935046wgh.5
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 18:38:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Sun, Feb 01, 2015 at 09:17:38PM -0800, Christopher Li wrote:
> On Fri, Jan 23, 2015 at 3:59 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Thanks for bringing to my attention.
> >
> > Here is a new version of the patch taking care of that.
> >
> 
> I like Sam's commit message better. So I merge a version using his
> commit message.
> 
> The branch for review is here:
> https://git.kernel.org/cgit/devel/sparse/chrisl/sparse.git/log/?h=review-counter
> 
> If there is no objects, I will merge it to master.
> 
> Chris
> --

Fine for me but Josh had a remark about the third test file (validation/preprocessor/counter3.c)
abusing a bit the test framework and I shared his feeling.

Here is a patch serie fixing this abuse by extending the test framework.


1/3) test-suite: add support for tests case involving several input files
2/3) test-suite: allow filename expansion of the input sections
3/3) test-suite: consolidate tests that require include files into single test files

 Documentation/test-suite                 | 11 +++++++++++
 validation/.gitignore                    |  1 +
 validation/pragma-once.c                 | 13 ++++++++++++-
 validation/preprocessor/counter2.c       | 16 +++++++++++-----
 validation/preprocessor/counter2.h       |  1 -
 validation/preprocessor/counter3.c       | 15 +++++++++++----
 validation/preprocessor/preprocessor20.c | 18 +++++++++++++++---
 validation/preprocessor/preprocessor20.h |  6 ------
 validation/test-suite                    | 11 +++++++++++
 validation/test-suite-file-expansion.c   | 22 ++++++++++++++++++++++
 10 files changed, 94 insertions(+), 20 deletions(-)
