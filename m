From: Christopher Li <sparse@chrisli.org>
Subject: Re: Potential issue in sparse_file()
Date: Fri, 16 Jun 2017 10:32:29 -0700
Message-ID: <CANeU7QkHJdpZS4JdKEH9JrzNZufdETXa+JcQtFgM9VmuCvwG3A@mail.gmail.com>
References: <CACXZuxemXEhsWmtB_Y6OD1XrLqCLk=pXqP+Z7NAv7ChWNEFCzw@mail.gmail.com>
 <CANeU7QkoeYYvjmND1yGT=Zt=sfCAMvtNm-z9RZmr9dgdYxU1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38402 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFPRcb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 13:32:31 -0400
Received: by mail-it0-f54.google.com with SMTP id b205so16868252itg.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 10:32:31 -0700 (PDT)
In-Reply-To: <CANeU7QkoeYYvjmND1yGT=Zt=sfCAMvtNm-z9RZmr9dgdYxU1Hg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 16, 2017 at 9:44 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Jun 16, 2017 at 5:33 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Hi,
>>
>> I noticed that sparse_file() closes the file descriptor even when it
>> is 0. Is this the intended behavior?
>
> I don't see a problem with it. The tokenize_stream() will keep reading
> the file descriptor until it hit EOF.
>
> If the stander input (file descriptor 0) already hit EOF, there is not much
> you can read from it any way. You might just as well close it.

That being said, the more correct behavior is adding a test,
 only close it when it is not zero. It will have impact on if some one
give the '-' twice to sparse.

I will accept a patch like that.

Chris
