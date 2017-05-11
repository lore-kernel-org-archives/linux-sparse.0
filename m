From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v7] sparse: add support for _Static_assert
Date: Thu, 11 May 2017 20:31:42 +0200
Message-ID: <CAMHZB6EVsKpxaQ2TQJ+CwUWPp6C_rHEtpQq1QgrRONN+iX1Ezw@mail.gmail.com>
References: <20170509184630.24086-1-lrichard@redhat.com> <CANeU7QkgoeW9JRG2xPs5Pa+YZ7ikQtoWFNSgXpp54m5FWXYgTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33248 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934091AbdEKSbn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 14:31:43 -0400
Received: by mail-qt0-f172.google.com with SMTP id t26so24502371qtg.0
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 11:31:43 -0700 (PDT)
In-Reply-To: <CANeU7QkgoeW9JRG2xPs5Pa+YZ7ikQtoWFNSgXpp54m5FWXYgTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 11, 2017 at 6:59 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, May 9, 2017 at 11:46 AM, Lance Richardson <lrichard@redhat.com> wrote:
>> This patch introduces support for the C11 _Static_assert() construct.
>>
>> Per the N1539 draft standard, the syntax changes for this construct
>> include:
>>
>>     declaration:
>>         <declaration-specifiers> <init-declarator-list>[opt] ;
>>         <static_assert-declaration>
>>
>>     struct-declaration:
>>         <specifier-qualifier-list> <struct-declarator-list>[opt] ;
>>         <static_assert-declaration>
>>
>>     static_assert-declaration:
>>         _Static_assert ( <constant-expression> , <string-literal> ) ;
>>
>> Signed-off-by: Lance Richardson <lrichard@redhat.com>
>> ---
>> v7: Incorporated additional feedback from Christopher Li and
>>     Luc van Oostenryck. Tested via "make check", also redefined
>>     Linux compiletime_assert() to use _Static_assert() when
>>     running sparse (gcc had issues with _Static_assert() in
>>     *.s files), no additional warnings were emitted.
>
> This version looks perfect for me.
>
> Signed-off-by: Chris Li <sparse@chrisli.org>
>
> Luc, do you want to apply the v7 and then I pull from your branch with
> the other identifier improvements? I can apply it but it might disrupt your
> branch.

Sure.

-- Luc
