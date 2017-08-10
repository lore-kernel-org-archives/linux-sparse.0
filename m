From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: RFC: Move Sparse development to github
Date: Thu, 10 Aug 2017 11:58:30 +0100
Message-ID: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:37462 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdHJK6b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 06:58:31 -0400
Received: by mail-vk0-f51.google.com with SMTP id r199so1326270vke.4
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 03:58:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I would like to propose moving Sparse development to github. The model
I would like to propose is as follows:

1. Development should occur in the github hosted repository.
2. When a release is cut it can be merged into the current Sparse repository.
3. Bugs and enhancement proposals should be managed through github issues.
4. My suggestion would that for enhancements a simple majority voting
should be adopted to ensure that features go in because Sparse users
want them.
5. I would also suggest separating out the testing infrastructure to
another repository so that more people can help with testing. I would
be interested in helping with the testing infrastructure as I believe
this will ease a lot of the pain experienced today with making
changes.
6. I also would like to see a multiple committer model for development
so that someone like Luc who is making significant contributions has
commit access.
7. Releases ought to be time based - i.e. a release must be cut every
three months or six months - with the current feature set.

I think moving development to github and adopting a multi-committer
model will significantly improve things. Changes could be done faster,
and contributors will be more motivated by having ownership.

I think this might be a controversial topic - so apologies for raising
it but having observed the process for the past six months I do think
change is necessary.

Regards
Dibyendu
