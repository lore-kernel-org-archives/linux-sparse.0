From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Wed, 15 Oct 2014 18:33:46 +0100
Message-ID: <543EAFFA.6070503@ramsay1.demon.co.uk>
References: <54398BA5.6050005@ramsay1.demon.co.uk> <CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47587 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbaJORdv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Oct 2014 13:33:51 -0400
In-Reply-To: <CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 15/10/14 15:23, Christopher Li wrote:
> On Sun, Oct 12, 2014 at 3:57 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>>
>> -       system ($check) == 0 or die;
>> +       system ($check) == 0 or exit 1;
> 
> Why not exit with the error code from sparse here?
> Sparse might exit with other error code than "1" in the future.

The meaning of the return value from system() is not portable.

If you read the perl documentation (e.g. perldoc -f system and
perldoc perlport [look for system() specific comments near the
end]), you will see that there is some variability. (This is
particularly true if it executes a shell to run the command).

However, I have found over the years that the situation is
much worse than even the perl documentation claims! (e.g. On
'platforms' like cygwin/MinGW/Win32-gnu/Win32-ActiveState and
even some unix systems).

About the only thing they all agree on is that a 0 return means
success. So, that is all I rely on, in general. This is helped
by the fact that most programs return either 0 or 1. For those
programs that do return multiple failure codes, I often don't
care why it failed - just that it did. In the very few cases
that I do care, then I do a 'best effort' knowing that it may
return the wrong code on some platforms.

Hmm, off the top of my head, something like:

    sub exit_code {
        my ($code) = @_;
        if ($code == -1) { # failed to execute
            $code = 1;
        }
        elsif ($code & 127) { # died with a signal (maybe)
            $code = 1;
        }
        elsif ($code != 0) { # non-zero exit code (maybe)
            my $t = ($code >> 8) & 0xff;
            $code = 1;
            if ($t > 0) {
                $code = $t;
            }
        }
        return $code;
    }

    system ($check) or exit exit_code($?);

However, I think the above is way overkill in this case. ;-)

ATB,
Ramsay Jones



