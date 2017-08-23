From: Christopher Li <sparse@chrisli.org>
Subject: Re: master merge plans
Date: Wed, 23 Aug 2017 16:50:07 -0400
Message-ID: <CANeU7Qm-YdXmeA-rgYa1A+hPb=TEDgXhBJy3m9zJ1m_wP6EpOw@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CANeU7QkQR6b936UR3VoYuzLGYdiOcTM=SaWtifsRNeF0rKhP+g@mail.gmail.com>
 <CANeU7Qm+LOCG2B7HXBbwsvCLR7bipHTH6nnkXtN7ruR8pNW6bA@mail.gmail.com> <CAMHZB6Hiqca+zi5eX8jN_-v9nZ3Cv2DwkW9isjyOSuUdvEnf6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34813 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932649AbdHWUuJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:50:09 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so7785724ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:50:08 -0700 (PDT)
In-Reply-To: <CAMHZB6Hiqca+zi5eX8jN_-v9nZ3Cv2DwkW9isjyOSuUdvEnf6Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 22, 2017 at 4:05 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> At worse these numbers show something like 0.1-0.3%.

I am doing some finial stage testing and reviewing the const expr patch.

I have find out that, my server actually do get affect by the CPU temperature.
So I turn off the Intel Turbo Stepping. Allow some rest between test.
Then I have finish write a script to do the testing per each commit.
I include the log in the email.

I can't narrow to one commit cause a big jump. No a reason to against
the patch. I am just interested to see that the measurement can catch
such change in numbers.

Chris

BTW, for testing purpose, I rebase against master. That is *not*
how I am going to merge it.


exp~0 17c0bae constexpr: flag __builtin_bswap() as constexpr

real 1m24.786s
user 20m18.346s
sys 7m24.193s

real 1m18.803s
user 20m55.562s
sys 7m36.994s

real 1m18.827s
user 20m55.731s
sys 7m36.688s

real 1m18.848s
user 20m57.298s
sys 7m35.525s

real 1m18.922s
user 20m56.519s
sys 7m36.264s
exp~1 58d888a give default return type in evaluate_call()

real 1m18.989s
user 20m59.896s
sys 7m35.895s

real 1m18.934s
user 20m58.567s
sys 7m36.808s

real 1m19.037s
user 20m58.249s
sys 7m37.441s

real 1m18.993s
user 20m59.233s
sys 7m36.422s

real 1m19.092s
user 20m58.818s
sys 7m37.009s
exp~2 ba12c3c return an error if too few args

real 1m18.984s
user 20m59.210s
sys 7m37.683s

real 1m18.993s
user 20m58.759s
sys 7m37.619s

real 1m19.133s
user 20m59.426s
sys 7m37.658s

real 1m19.067s
user 21m0.375s
sys 7m36.571s

real 1m19.040s
user 20m59.331s
sys 7m37.687s
exp~3 ace5869 constexpr: treat comparisons between types as integer constexpr

real 1m18.853s
user 20m57.653s
sys 7m37.073s

real 1m18.870s
user 20m56.782s
sys 7m38.441s

real 1m18.949s
user 20m56.683s
sys 7m37.473s

real 1m19.101s
user 20m57.496s
sys 7m37.183s

real 1m18.889s
user 20m57.439s
sys 7m37.235s
exp~4 82f78d2 constexpr: support compound literals as address constants

real 1m18.966s
user 20m56.740s
sys 7m37.477s

real 1m18.882s
user 20m55.245s
sys 7m38.047s

real 1m18.872s
user 20m56.149s
sys 7m37.610s

real 1m19.015s
user 20m54.708s
sys 7m38.447s

real 1m18.831s
user 20m55.296s
sys 7m37.978s
exp~5 df2d126 constexpr: relax some constant expression rules for
pointer expressions

real 1m18.831s
user 20m55.178s
sys 7m37.580s

real 1m18.802s
user 20m55.791s
sys 7m36.577s

real 1m18.920s
user 20m55.301s
sys 7m37.593s

real 1m18.801s
user 20m54.810s
sys 7m37.699s

real 1m18.814s
user 20m55.836s
sys 7m36.516s
exp~6 96f5c7e constexpr: flag builtins constant_p, safe_p and warning
as constexprs

real 1m19.001s
user 20m54.861s
sys 7m39.497s

real 1m18.894s
user 20m54.176s
sys 7m39.225s

real 1m18.955s
user 20m55.225s
sys 7m38.273s

real 1m18.837s
user 20m55.395s
sys 7m38.423s

real 1m19.038s
user 20m56.132s
sys 7m37.417s
exp~7 82ba05e constexpr: examine constness of __builtin_offsetof at
evaluation only

real 1m18.844s
user 20m52.640s
sys 7m38.045s

real 1m18.796s
user 20m52.641s
sys 7m38.324s

real 1m18.908s
user 20m53.584s
sys 7m37.451s

real 1m18.842s
user 20m52.688s
sys 7m38.812s

real 1m18.806s
user 20m53.336s
sys 7m37.414s
exp~8 f585495 constexpr: recognize references to labels as address constants

real 1m18.921s
user 20m53.766s
sys 7m37.205s

real 1m18.784s
user 20m53.527s
sys 7m37.331s

real 1m18.846s
user 20m54.222s
sys 7m36.130s

real 1m18.900s
user 20m53.766s
sys 7m36.899s

real 1m18.676s
user 20m53.485s
sys 7m37.334s
exp~9 c19757f constexpr: recognize string literals as address constants

real 1m19.184s
user 20m54.707s
sys 7m37.612s

real 1m18.782s
user 20m54.507s
sys 7m37.990s

real 1m18.830s
user 20m54.008s
sys 7m38.648s

real 1m18.984s
user 20m53.784s
sys 7m38.611s

real 1m18.770s
user 20m53.433s
sys 7m39.090s
exp~10 a1ba3b8 constexpr: recognize members of static compound objects
as address constants

real 1m19.012s
user 20m53.325s
sys 7m37.647s

real 1m18.815s
user 20m53.541s
sys 7m38.065s

real 1m18.716s
user 20m52.065s
sys 7m39.047s

real 1m18.762s
user 20m52.854s
sys 7m38.205s

real 1m18.867s
user 20m53.234s
sys 7m38.251s
exp~11 89f03a1 constexpr: recognize address constants created through
pointer arithmetic

real 1m18.891s
user 20m56.707s
sys 7m37.824s

real 1m18.944s
user 20m56.198s
sys 7m37.925s

real 1m18.980s
user 20m57.025s
sys 7m37.688s

real 1m18.861s
user 20m56.359s
sys 7m38.265s

real 1m18.927s
user 20m56.978s
sys 7m37.942s
exp~12 add9d6b constexpr: recognize address constants created through casts

real 1m18.827s
user 20m54.727s
sys 7m37.786s

real 1m18.823s
user 20m55.051s
sys 7m37.619s

real 1m18.840s
user 20m55.395s
sys 7m37.611s

real 1m18.828s
user 20m54.439s
sys 7m37.358s

real 1m18.996s
user 20m55.342s
sys 7m37.761s
exp~13 1c5d817 constexpr: recognize static objects as address constants

real 1m18.849s
user 20m55.353s
sys 7m37.570s

real 1m18.951s
user 20m55.800s
sys 7m36.969s

real 1m18.901s
user 20m56.035s
sys 7m37.285s

real 1m19.008s
user 20m54.143s
sys 7m38.469s

real 1m18.851s
user 20m54.583s
sys 7m38.325s
exp~14 5931437 constexpr: check static storage duration objects'
intializers' constness

real 1m18.963s
user 20m57.428s
sys 7m36.810s

real 1m18.992s
user 20m57.136s
sys 7m37.428s

real 1m18.990s
user 20m57.323s
sys 7m36.503s

real 1m18.889s
user 20m57.453s
sys 7m37.012s

real 1m18.916s
user 20m56.250s
sys 7m37.578s
exp~15 3d1f615 constexpr: collect storage modifiers of initializers

real 1m18.620s
user 20m50.093s
sys 7m38.680s

real 1m18.710s
user 20m52.010s
sys 7m37.180s

real 1m18.658s
user 20m51.324s
sys 7m37.858s

real 1m18.708s
user 20m50.750s
sys 7m38.064s

real 1m18.729s
user 20m50.268s
sys 7m38.261s
exp~16 c5b00b9 constexpr: rename handle_simple_initializer() to
handle_initializer()

real 1m18.762s
user 20m53.856s
sys 7m39.205s

real 1m19.032s
user 20m53.479s
sys 7m39.081s

real 1m18.952s
user 20m53.434s
sys 7m39.073s

real 1m18.841s
user 20m53.849s
sys 7m38.662s

real 1m18.876s
user 20m53.638s
sys 7m39.069s
exp~17 ce1284b constexpr: add support for tagging address constants

real 1m18.841s
user 20m53.490s
sys 7m38.805s

real 1m18.808s
user 20m53.957s
sys 7m39.191s

real 1m18.979s
user 20m54.010s
sys 7m38.661s

real 1m18.923s
user 20m53.627s
sys 7m39.547s

real 1m18.837s
user 20m54.008s
sys 7m38.673s
exp~18 ca44c48 constexpr: add support for tagging arithmetic constant
expressions

real 1m18.732s
user 20m52.681s
sys 7m37.328s

real 1m18.795s
user 20m52.313s
sys 7m37.950s

real 1m18.755s
user 20m52.972s
sys 7m37.638s

real 1m18.964s
user 20m52.372s
sys 7m38.090s

real 1m18.906s
user 20m52.971s
sys 7m37.603s
exp~19 1d14279 constexpr: examine constness of conditionals at evaluation only

real 1m18.778s
user 20m52.130s
sys 7m38.598s

real 1m18.781s
user 20m53.484s
sys 7m37.828s

real 1m18.917s
user 20m53.524s
sys 7m37.803s

real 1m18.855s
user 20m52.568s
sys 7m38.649s

real 1m18.880s
user 20m52.250s
sys 7m38.596s
exp~20 d032f28 constexpr: examine constness of preops at evaluation only

real 1m18.670s
user 20m52.232s
sys 7m37.297s

real 1m18.740s
user 20m51.975s
sys 7m37.008s

real 1m18.690s
user 20m51.828s
sys 7m37.761s

real 1m18.874s
user 20m50.968s
sys 7m38.967s

real 1m18.689s
user 20m51.353s
sys 7m37.997s
exp~21 2322e92 constexpr: examine constness of binops and alike at
evaluation only

real 1m18.848s
user 20m52.420s
sys 7m38.549s

real 1m18.964s
user 20m53.504s
sys 7m37.359s

real 1m18.687s
user 20m52.094s
sys 7m39.136s

real 1m18.730s
user 20m52.640s
sys 7m38.264s

real 1m18.738s
user 20m52.135s
sys 7m38.986s
exp~22 63db9df constexpr: examine constness of casts at evaluation only

real 1m18.931s
user 20m52.036s
sys 7m38.964s

real 1m18.781s
user 20m51.949s
sys 7m38.190s

real 1m18.822s
user 20m52.409s
sys 7m38.207s

real 1m18.819s
user 20m51.696s
sys 7m39.160s

real 1m18.939s
user 20m51.307s
sys 7m39.398s
exp~23 3a4d6eb constexpr: init flags at expression allocation

real 1m18.735s
user 20m51.678s
sys 7m37.659s

real 1m18.763s
user 20m51.829s
sys 7m37.649s

real 1m18.878s
user 20m51.538s
sys 7m37.923s

real 1m18.764s
user 20m51.689s
sys 7m37.561s

real 1m18.842s
user 20m50.505s
sys 7m38.146s
exp~24 6b1e4ad constexpr: introduce additional expression constness
tracking flags

real 1m18.821s
user 20m52.272s
sys 7m38.586s

real 1m18.829s
user 20m50.961s
sys 7m39.365s

real 1m18.821s
user 20m52.493s
sys 7m38.452s

real 1m18.850s
user 20m51.705s
sys 7m39.267s

real 1m18.923s
user 20m53.136s
sys 7m37.625s
exp~25 9151ef4 gcc attr: add nonstring warn_if_not_aligned

real 1m18.813s
user 20m51.490s
sys 7m38.610s

real 1m18.703s
user 20m50.492s
sys 7m38.937s

real 1m18.723s
user 20m50.613s
sys 7m38.524s

real 1m18.654s
user 20m52.010s
sys 7m37.222s

real 1m18.790s
user 20m51.441s
sys 7m38.248s
