From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Date: Sat, 30 Mar 2019 08:40:16 -0400
Message-ID: <20190330084016.24f8ad46@gandalf.local.home>
References: <20190325195303.GA20629@hari-Inspiron-1545>
        <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
        <20190330110747.GA3461@hari-Inspiron-1545>
        <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>, mingo@redhat.com, roopa@cumulusnetworks.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, 30 Mar 2019 13:01:41 +0100
Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> OK, I see. IMO, it would be better to have 2 patches for this:
> one for the redundant assignment to pin6 and anotther one for
> the IS_ENABLED() change but feel free, if needed, to add my

I agree with it being separate patches. I'm big on the "one patch
accomplishes one task" ideology.

-- Steve
