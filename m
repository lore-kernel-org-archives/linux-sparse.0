From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Thu, 16 Oct 2014 09:45:02 +0800
Message-ID: <CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>
References: <54398BA5.6050005@ramsay1.demon.co.uk>
	<CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>
	<543EAFFA.6070503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42062 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaJPBpE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Oct 2014 21:45:04 -0400
Received: by mail-qc0-f171.google.com with SMTP id i17so2046408qcy.2
        for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2014 18:45:02 -0700 (PDT)
In-Reply-To: <543EAFFA.6070503@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hi,

I create a branch in the chrisl repo call "review-ramsay" for your new
follow up patches.
I plan to do incremental fix up if any on that branch. Then when we
both happy about it,
I will do rebase and smash the commit before push to master branch.



On Thu, Oct 16, 2014 at 1:33 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> On 15/10/14 15:23, Christopher Li wrote:
>> On Sun, Oct 12, 2014 at 3:57 AM, Ramsay Jones
>> <ramsay@ramsay1.demon.co.uk> wrote:
>>>
>>>
>>> -       system ($check) == 0 or die;
>>> +       system ($check) == 0 or exit 1;
>>
>> Why not exit with the error code from sparse here?
>> Sparse might exit with other error code than "1" in the future.
>
> The meaning of the return value from system() is not portable.

I see. Does it mean we should use some thing other than "system".
or maybe some thing like:

$retcode = system($check);
if $retcode !=0 { exit $retcode; }

I don't use Perl so that might not be valid Perl.

> Hmm, off the top of my head, something like:
>
>     sub exit_code {
>         my ($code) = @_;
>         if ($code == -1) { # failed to execute
>             $code = 1;
>         }
>         elsif ($code & 127) { # died with a signal (maybe)
>             $code = 1;
>         }
>         elsif ($code != 0) { # non-zero exit code (maybe)
>             my $t = ($code >> 8) & 0xff;
>             $code = 1;
>             if ($t > 0) {
>                 $code = $t;
>             }
>         }
>         return $code;
>     }
>
>     system ($check) or exit exit_code($?);
>
> However, I think the above is way overkill in this case. ;-)

Yes, I agree, that is way overkill.

Chris
