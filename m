From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] compiler.h: update definition of unreachable()
Date: Mon, 15 Oct 2018 23:14:57 +0200
Message-ID: <CANiq72=PMEqu__HjQ-Y7DmzbWMRQPY6gQ5MF0cd9gF6vbCj=8Q@mail.gmail.com>
References: <20181015172221.35709-1-ndesaulniers@google.com>
 <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com> <CAKwvOdnwfXSdBw_Y2zpAEdcn3aWRqUq9Fh8uk8EnkxPMC+c2Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdnwfXSdBw_Y2zpAEdcn3aWRqUq9Fh8uk8EnkxPMC+c2Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: luto@amacapital.net, Josh Poimboeuf <jpoimboe@redhat.com>, Nathan Chancellor <natechancellor@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 15, 2018 at 10:13 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Looking at commit cb984d101b30 ("compiler-gcc: integrate the various
> compiler-gcc[345].h files") it seems that the comment is referring to
> gcc 4.4 not supporting __builtin_unreachable().  Looks like it was
> added in 4.5 timeframe: https://godbolt.org/z/ugv5QO, so the comment
> can be deleted.  Would you prefer a v2 (single patch), or an
> additional patch on top?

Split would be better, I think, since the changes can be applied
independetly even if related. If you are busy, I can do it myself, so
don't worry too much. :)

Cheers,
Miguel
