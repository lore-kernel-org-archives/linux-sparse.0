From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3] test-suite: add support for tests case involving
 several input files
Date: Fri, 6 Feb 2015 07:02:08 -0800
Message-ID: <CANeU7QnHX_v=0S1jd1TbWq5UmTCsoKibwO=A64_JdEV54QZXRg@mail.gmail.com>
References: <54C15E0E.4000008@de.ibm.com>
	<CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
	<20150123222332.GB42179@macpro.local>
	<20150123223856.GB1489@cloud>
	<20150123235934.GA42931@macpro.local>
	<CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
	<20150204024625.GB7731@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:61571 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbbBFPCJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2015 10:02:09 -0500
Received: by mail-qc0-f177.google.com with SMTP id p6so12150657qcv.8
        for <linux-sparse@vger.kernel.org>; Fri, 06 Feb 2015 07:02:08 -0800 (PST)
In-Reply-To: <20150204024625.GB7731@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Feb 3, 2015 at 6:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> These input files, instead of being stored in real files and thus polluting/confusing
> the test framework are now placed in a serie of sections inside an unique test file.
> These sections are delimited by new tags: input-file-1-start / input-file-1-end, / input-file-2-start/ ...

Sorry for the late review. Can I summarize the polluting/confusing problem as:
If there is more than one C file was used in one test case, and test suit wll
invoke each of the C file as a separate test case, not  a good thing.

I think merging it into one test file then split them by the test suit
is too complicated.
It is actually easier to maintain them as separate files.

I think the simpler way would be just teach the test suit, some file
was mean to be
part of a separate test case. Just don't invoke it as stand alone test.
We can add some rules like, embed a tag or simply reflect that in the file name.

It will be a smaller change to the test suit as well.

Thanks

Chris
