From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse testing
Date: Sat, 1 Apr 2017 14:11:36 +0100
Message-ID: <CACXZuxeo-JFVTa8W0RLOJG-KEb2vdRO8HLFYcTOko-Eq1+u=DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33228 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdDANLh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Apr 2017 09:11:37 -0400
Received: by mail-io0-f169.google.com with SMTP id f84so53793405ioj.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Apr 2017 06:11:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

With regards to the recent discussion of the pain in merging changes,
and also generally, I think that the Sparse test suite needs to be
enhanced. My impression is that most tests do not validate the
generated linearized IR. The sparse-llvm tests do not validate the
generated LLVM IR either.

Without such validation it is hard to detect when some change breaks
stuff. I think that having robust tests will also ease the pain of
merging contributions as you will be able to detect breaks more
reliably.

Because of this reason, I have been reluctant to merge changes into my
repository as I first want to have a set of regression tests that I
can run whenever I merge changes. I have done some work on this. As
validating sparse IR and LLVM IR is relatively difficult since even a
spurious change in the IR output will cause tests to fail - the
approach I have taken is that all tests are designed to be run. The
success of the test is therefore determined by whether the compiled
test runs correctly and generates the required outputs.

Ideally we need a mix of simple unit tests and complex real life
programs, as not all issues can be caught by simple tests.

I am happy to contribute the tests I have been creating. I have
sourced many of them from other opensource projects: I think that they
are all permissively licensed. But even if some license conflicts, all
that is needed is excluding the tests from the distribution I think.
In my view it is still worth having these tests run every time there
is a change.

Unfortunately all my tests need a working sparse-llvm component. So
until all the changes I have done are reflected in sparse, the tests
will not compile I think. As I have reported before the current patch
series does not cover all the fixes, therefore additional fixes are
needed.

Regards
Dibyendu
