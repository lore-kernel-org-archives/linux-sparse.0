From: Roopa Prabhu <roopa@cumulusnetworks.com>
Subject: Re: [PATCH] trace: events: fix error directive in argument list
Date: Sat, 30 Mar 2019 06:50:38 -0700
Message-ID: <CAJieiUgLUV=z-OSJdevVpKsdUB3PvWRtwueqf0o7oGMX2VLMiw@mail.gmail.com>
References: <20190325195303.GA20629@hari-Inspiron-1545> <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
 <20190330110747.GA3461@hari-Inspiron-1545> <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
 <20190330084016.24f8ad46@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330084016.24f8ad46@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, mingo@redhat.com, David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Mar 30, 2019 at 5:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 30 Mar 2019 13:01:41 +0100
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
>
> > OK, I see. IMO, it would be better to have 2 patches for this:
> > one for the redundant assignment to pin6 and anotther one for
> > the IS_ENABLED() change but feel free, if needed, to add my
>
> I agree with it being separate patches. I'm big on the "one patch
> accomplishes one task" ideology.
>

yes, I will take care of the pin6 assignment separately. This patch
can only address the sparse error.
