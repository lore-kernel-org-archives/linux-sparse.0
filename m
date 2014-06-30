From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 2/2] lib.c: skip --param parameters
Date: Mon, 30 Jun 2014 01:51:57 -0700
Message-ID: <CANeU7Qk6e-CAK_aRTzq=ev_esQ9uGsbc6ihH7m-0=ngoPotVzg@mail.gmail.com>
References: <1402996306-6811-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1402996306-6811-3-git-send-email-andriy.shevchenko@linux.intel.com>
	<CANeU7QnLad1f4KkLpTGSWB8eD8_La-tACim6rR7DLQ=hggwhOQ@mail.gmail.com>
	<1404117165.5102.3.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404117165.5102.3.camel@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Jun 30, 2014 at 1:32 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Hmm... I'd just added test printf to the handle_param() and see if I
> print *next, it is either --param or --param=*. So, using return (next +
> 2) helps, otherwise we end up with the same situation as before patch.

The return value from handle_switch() is a bit tricky. It is actually points to
the current args which about to be expired.

Take a look at this code which invoke the handle_switch().
    for (;;) {
        char *arg = *++args;      <---------------- notice the ++
before the fetch
        if (!arg)
            break;

        if (arg[0] == '-' && arg[1]) {
            args = handle_switch(arg+1, args); <-------- args return here.
            continue;
        }
        add_ptr_list_notag(filelist, arg);
    }

>
> What did I miss?

So the caller loop will perform 1 pointer advance before fetch.
Your code can advance 2 pointer, so that is  total 3 pointer advance.

>
> Which was explicitly mentioned in the commit message.

Sorry about that, I jump to the code first. I later notice that  in
the commit message as well.

Any way, the change I push should fix all that.

Chris
