From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Some thoughts on the SSA debate
Date: Fri, 8 Sep 2017 11:28:57 +0100
Message-ID: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36634 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdIHK26 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Sep 2017 06:28:58 -0400
Received: by mail-ua0-f181.google.com with SMTP id q29so3401591uaf.3
        for <linux-sparse@vger.kernel.org>; Fri, 08 Sep 2017 03:28:58 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

Having tried out the newssa approach for a bit, and after working on
another backend that doesn't use SSA phi nodes, I would like to share
some of my personal thoughts with regards to the changes:

1. Firstly I think it is important to retain the existing "pre-phi"
linear code. This is fine for backends such as LLVM which do a good
job of transforming code anyway. It is also usually less buggy and
serves as a baseline for correctness. So after careful consideration I
would vote against adding phi instructions in the initial phase.

2. It also appears to me that the original phi instructions, while not
textbook correct in terms of placement, are internally consistent, in
the sense that the only issue I have found so far is the inability to
handle variables that are initialized in a branch of the code. Perhaps
this is just a bug? The other issue with the original implementation
appears to be related to the patches that attempted to kill things -
but I get the feeling that the original design did not envision
removing unused things physically, but just marked them logically
dead?

3. It also appears that the SSA construction approach by Matthias
Braun et al is inadequate in the sense that it is not a full solution
and requires additional hacks. This is unfortunate as I understood the
aim was to avoid hacks and ad-hoc changes and go with a more published
algorithm. In view of this, perhaps the current experiment has failed
and the effort should be directed to building the industry standard
approach?

4. Final thought is that although I was previously suggesting changes
should go into master, I think for such a large piece of fundamental
work maybe the changes should be done on a dedicated branch and only
merged when completely tested and validated.

I hesitated putting forth my thoughts here as I still have the freedom
in my project to accept / reject changes happening in Sparse, and so I
am able to take a different approach. Also, I am not really qualified
to judge the full implications of the new SSA construction approach -
hence I am going by my impressions after testing and using the
approach, and observing the issues that have been discussed so far on
the list.

Regards
Dibyendu
