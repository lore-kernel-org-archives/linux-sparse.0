From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 2/3 v2] Handle all enum members in case statements
Date: Tue, 4 Aug 2015 19:52:14 -0400
Message-ID: <55C1502E.5050609@redhat.com>
References: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
 <1438689994-30940-1-git-send-email-tcamuso@redhat.com>
 <CANeU7Qk7Xvs6RQuzDxq-9BrqCg-6VXnDUxmgwkREpWVX4Y2ynQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbbHDXwP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Aug 2015 19:52:15 -0400
In-Reply-To: <CANeU7Qk7Xvs6RQuzDxq-9BrqCg-6VXnDUxmgwkREpWVX4Y2ynQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, nicstange@gmail.com


On 08/04/2015 07:31 PM, Christopher Li wrote:
> On Tue, Aug 4, 2015 at 8:06 AM, Tony Camuso <tcamuso@redhat.com> wrote:
>> Missing enum members in case statements in c2xml.c and parse.c were
>> causing compile time complaints by gcc 5.1.1. Better to explicitly
>> handle all enum members of the switch variable in case statements,
>> even if they just break.
>>                  break;
>> +       case SYM_PREPROCESSOR:
>> +       case SYM_BASETYPE:
>> +       case SYM_NODE:
>> +       case SYM_PTR:
>> +       case SYM_ARRAY:
>> +       case SYM_ENUM:
>> +       case SYM_TYPEDEF:
>> +       case SYM_TYPEOF:
>> +       case SYM_MEMBER:
>> +       case SYM_BITFIELD:
>> +       case SYM_LABEL:
>> +       case SYM_RESTRICT:
>> +       case SYM_FOULED:
>> +       case SYM_KEYWORD:
>> +       case SYM_BAD:
>> +               break;
>
> I think adding a "default: break" should work. I like your previous patch
> better, except maybe adding a line break after default.
>

It was mentioned to me that the new prevailing wisdom is to "Prefer
compile time errors to runtime errors", such that each enum'd value
of a switch variable should be explicitly handled.

I seem to have violated the spirit of that paradigm by using fall through.

I could add a new line and "break" statement after each case.

Or, if you prefer, I can resubmit the original patch with a linefeed after
the "default:" for good form. Either way, I believe the compiler optimize
them the same.

>
>>                          case SYM_ENUM:
>>                          case SYM_RESTRICT:
>>                                  base_type->ident = ident;
>> +                       case SYM_PREPROCESSOR:
>> +                       case SYM_BASETYPE:
>
> I notice this has the follow through behavior. It is not a bug.
> But if some one append some new case there, it is easy to
> cause unintended follow through. It is better add a break there.

It may not be a bug today, but without an explicit break for each,
it's a potential bug.

The whole reason for explicitly listing the existing enum members is so
that new cases for which "break" may not be the correct solution can be
easily identified at compile time.

Tony


